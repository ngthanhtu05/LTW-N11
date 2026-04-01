package com.n11.sportshop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.n11.sportshop.domain.CartDetail;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.UserVoucher;
import com.n11.sportshop.domain.Voucher;
import com.n11.sportshop.domain.dto.InformationDTO;
import com.n11.sportshop.service.CartService;
import com.n11.sportshop.service.OrderService;
import com.n11.sportshop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;


@Controller
@RequestMapping("/cart")
@Transactional
public class ClientCartController {

    private final CartService cartService;
    private final UserService userService;
    private final OrderService orderService;
    public ClientCartController(CartService cartService, OrderService orderService, UserService userService) {
        this.cartService = cartService;
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");
        User user = this.userService.getUserByID(userId);
        List<CartDetail> cartDetails = this.cartService.getCartDetails(user);
        Long totalPrice = 0L;  
        String hasToDeleteProduct = "false";
        TreeMap<Integer, String> errors = new TreeMap<>();
        for (CartDetail item : cartDetails) {
            Long price = item.getProduct().getPrice();
            Integer quantity = item.getQuantity();
            Integer stock = item.getProduct().getStockQuantity();
            if (stock == 0) {
                // sản phẩm hết hàng -> có thể gỡ khỏi giỏ hoặc đặt quantity=0
                item.setQuantity(0);
                errors.put(item.getProduct().getId(), "Sản phẩm này đã hết hàng");
                hasToDeleteProduct = "true";
            } else if (quantity > stock) {
                // số lượng trong giỏ vượt quá stock -> giảm xuống tối đa
                item.setQuantity(stock);
                errors.put(item.getProduct().getId(), "Chỉ còn " + stock + " sản phẩm");
            }
            totalPrice = totalPrice + (price * quantity);
        }
        if (!errors.isEmpty()) {
            model.addAttribute("errors", errors);
        }
        model.addAttribute("hasToDeleteProduct", hasToDeleteProduct);
        model.addAttribute("items", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/show";
    }

    @PostMapping("/update")
    public void updateCart(@RequestParam("id") int id,
            @RequestParam("quantity") int quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        User user = userService.getUserByID((int) session.getAttribute("id"));
        cartService.updateCart(user, id, quantity);
    }

    @PostMapping("/delete/{id}")
    public String deleteCartItem(@PathVariable("id") int id) {
        this.cartService.deleteItemInCart(id);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOut(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");
        String token = UUID.randomUUID().toString();
        session.setAttribute("checkoutToken", token);
        User user = this.userService.getUserByID(userId);
        List<CartDetail> cartDetails = this.cartService.getCartDetails(user);
        if(cartDetails.isEmpty()) {
            return "redirect:/cart?error=empty";
        }
        Long totalPrice = 0L;
        
        for (CartDetail item : cartDetails) {
            Long price = item.getProduct().getPrice();
            Integer quantity = item.getQuantity();
            if (item.getProduct().getStockQuantity() < item.getQuantity()) {
                return "redirect:/cart";
            }
            totalPrice = totalPrice + (price * quantity);
        }
        ArrayList<Voucher> vouchers = new ArrayList<>();
        List<UserVoucher> userVouchers = this.userService.getActiveVoucherListMoreThan(user, 1);
        for (var item : userVouchers) {
            vouchers.add(item.getVoucher());
        }
        model.addAttribute("vouchers", vouchers);
        model.addAttribute("error", "");
        model.addAttribute("bill", new InformationDTO());
        model.addAttribute("items", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("shipPrice", 30000);
        model.addAttribute("discountValue", 0);
        return "client/cart/checkout";
    }
}
