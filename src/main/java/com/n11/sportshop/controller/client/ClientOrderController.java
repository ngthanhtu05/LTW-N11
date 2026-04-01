package com.n11.sportshop.controller.client;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.n11.sportshop.domain.Cart;
import com.n11.sportshop.domain.Order;
import com.n11.sportshop.domain.OrderDetail;
import com.n11.sportshop.domain.OrderStatus;
import com.n11.sportshop.domain.PaymentStatus;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.dto.InformationDTO;
import com.n11.sportshop.service.CartService;
import com.n11.sportshop.service.OrderService;
import com.n11.sportshop.service.ProductService;
import com.n11.sportshop.service.UserService;
import com.n11.sportshop.service.VNPayService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/order")
public class ClientOrderController {

    private final CartService cartService;
    private final UserService userService;
    private final OrderService orderService;
    private final VNPayService vNPayService;
    private final ProductService productService;

    @GetMapping
    public String getUserOrderPendingPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Integer id = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(id);
        List<Order> orders = this.orderService.getOrderHistoryByStatus(user, OrderStatus.pending);
        Collections.reverse(orders);
        model.addAttribute("status", "pending");
        model.addAttribute("orders", orders);
        return "client/order/show";
    }

    public ClientOrderController(CartService cartService, UserService userService, OrderService orderService,
            VNPayService vNPayService, ProductService productService) {
        this.cartService = cartService;
        this.userService = userService;
        this.orderService = orderService;
        this.vNPayService = vNPayService;
        this.productService = productService;
    }

    @GetMapping("/shipping")
    public String getUserOrderShippingPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Integer id = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(id);
        List<Order> orders = this.orderService.getOrderHistoryByStatus(user, OrderStatus.shipped);
        Collections.reverse(orders);
        model.addAttribute("status", "shipping");
        model.addAttribute("orders", orders);
        return "client/order/show";
    }

    @GetMapping("/accept")
    public String getUserOrderAcceptPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Integer id = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(id);
        List<Order> orders = this.orderService.getOrderHistoryByStatus(user, OrderStatus.accept);
        Collections.reverse(orders);
        model.addAttribute("status", "accepted");
        model.addAttribute("orders", orders);
        return "client/order/show";
    }

    @GetMapping("/cancel")
    public String getUserOrderCancelPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Integer id = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(id);
        List<Order> orders = this.orderService.getOrderHistoryByStatus(user, OrderStatus.canceled);
        Collections.reverse(orders);
        model.addAttribute("status", "canceled");
        model.addAttribute("orders", orders);
        return "client/order/show";
    }

    @PostMapping("/create")
    public String createOrder(
            @ModelAttribute("bill") @Valid InformationDTO informationDTO,
            // BindingResult orderBindingResult,
            @RequestParam("payment") Optional<String> payment,
            HttpServletRequest http,
            @RequestParam("checkoutToken") String token) throws Exception {

        // Validate
        // List<FieldError> errors = orderBindingResult.getFieldErrors();
        // for (FieldError error : errors) {
        // System.out.println(">>>>" + error.getObjectName() + " - " +
        // error.getDefaultMessage());
        // }

        // if (orderBindingResult.hasErrors()) {
        // return "client/cart/checkout";
        // }

        HttpSession session = http.getSession(false);
        String sessionToken = (String) session.getAttribute("checkoutToken");
        if (sessionToken == null || !sessionToken.equals(token)) {
            return "redirect:/cart?error=invalid_or_used_token";
        }
        session.removeAttribute("checkoutToken");

        final String uuid = UUID.randomUUID().toString().replace("-", "");
        informationDTO.setPaymentRef(uuid);
        if (!informationDTO.getPayment().equals("CASH")) {
            String ip = this.vNPayService.getIpAddress(http);
            String vnpUrl = this.vNPayService.generateVNPayURL(informationDTO.getTotalPrice(),
                    informationDTO.getPaymentRef(), ip);
            Integer userId = (Integer) session.getAttribute("id");
            if (informationDTO.getVoucherCode() == null || informationDTO.getVoucherCode().isEmpty()
                    || informationDTO.getVoucherCode().isBlank()) {
                informationDTO.setVoucherCode("NONE");
            }
            try {
                Order order = this.orderService.createOrder(userId, informationDTO.getVoucherCode(), informationDTO);
                return "redirect:" + vnpUrl;
            } catch (Exception e) {
                return "redirect:/cart?error=not_enough_quantity";
            }
        } else {
            Integer userId = (Integer) session.getAttribute("id");
            if (informationDTO.getVoucherCode() == null || informationDTO.getVoucherCode().isEmpty()
                    || informationDTO.getVoucherCode().isBlank()) {
                informationDTO.setVoucherCode("NONE");
            }
            try {
                Order order = this.orderService.createOrder(userId, informationDTO.getVoucherCode(), informationDTO);
                return "redirect:/order/confirmation";
            } catch (Exception e) {
                return "redirect:/cart?error=not_enough_quantity";
            }
        }
    }

    @GetMapping("/payment-return")
    public String paymentReturn(
            @RequestParam("vnp_ResponseCode") Optional<String> vnpayResponseCode,
            @RequestParam("vnp_TxnRef") Optional<String> paymentRef,
            Model model) {
        String responseCode = vnpayResponseCode.get();

        Order order = orderService.getOrderByPaymentRef(paymentRef.get());

        if ("00".equals(responseCode)) {
            order.setPaymentStatus(PaymentStatus.PAID);
        } else {
            for (var item : order.getOrderDetails()) {
                Product product = this.productService.getProductById(item.getProduct().getId()).get();
                product.setStockQuantity(product.getStockQuantity() + item.getQuantity());
                this.productService.saveProduct(product, null);
            }
            return "redirect:/cart?error=not_paid";
        }

        return "redirect:/order/confirmation";
    }

    @GetMapping("/confirmation")
    public String getConfirmation(
            Model model,
            HttpServletRequest request) {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(userId);
        Cart cart = this.cartService.getActiveCart(user);
        this.cartService.deleteCart(user, cart);
        List<OrderDetail> orderDetails = this.orderService.getOrderDetails(user);
        Order order = this.orderService.getOrderByUser(user);
        Long totalPrice = order.getShipPrice() + order.getTotalAmount() - order.getDiscountAmount();
        if (totalPrice < 0) {
            totalPrice = 0L;
        }
        model.addAttribute("items", orderDetails);
        model.addAttribute("shipping", order.getShipPrice());
        model.addAttribute("subTotal", order.getTotalAmount());
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("discountAmount", order.getDiscountAmount());
        model.addAttribute("information", order);
        return "client/order/confirmation";
    }

    @PostMapping("/cancel/{id}")
    public String cancelOrderStatus(@PathVariable("id") Integer id) {
        this.orderService.updateOrderStatus(id, OrderStatus.canceled);
        return "redirect:/order/cancel";
    }

    @PostMapping("/accept/{id}")
    public String acceptOrderStatus(@PathVariable("id") Integer id) {
        this.orderService.updateOrderStatus(id, OrderStatus.accept);
        return "redirect:/order/accept";
    }
}
