package com.n11.sportshop.controller.admin;

import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.n11.sportshop.domain.Order;
import com.n11.sportshop.domain.OrderDetail;
import com.n11.sportshop.domain.OrderStatus;
import com.n11.sportshop.service.OrderService;

@Controller
@RequestMapping("/admin/order")
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping
    public String getOrderPage(Model model) {
        model.addAttribute("pendingCount", this.orderService.countByStatus(OrderStatus.pending));
        model.addAttribute("shippingCount", this.orderService.countByStatus(OrderStatus.shipped));
        model.addAttribute("acceptedCount", this.orderService.countByStatus(OrderStatus.accept));
        model.addAttribute("canceledCount", this.orderService.countByStatus(OrderStatus.canceled));
        return "redirect:/admin/order/pending";
    }

    @GetMapping("/pending")
    public String getOrderPending(Model model) {
        List<Order> orders = this.orderService.getOrderByStatus(OrderStatus.pending);
        Collections.reverse(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("status", "Pending");
        model.addAttribute("pendingCount", this.orderService.countByStatus(OrderStatus.pending));
        model.addAttribute("shippingCount", this.orderService.countByStatus(OrderStatus.shipped));
        model.addAttribute("acceptedCount", this.orderService.countByStatus(OrderStatus.accept));
        model.addAttribute("canceledCount", this.orderService.countByStatus(OrderStatus.canceled));
        return "admin/order/show";
    }

    @GetMapping("/shipping")
    public String getOrderShipping(Model model) {
        List<Order> orders = orderService.getOrderByStatus(OrderStatus.shipped);
        Collections.reverse(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("status", "Shipping");
        model.addAttribute("pendingCount", this.orderService.countByStatus(OrderStatus.pending));
        model.addAttribute("shippingCount", this.orderService.countByStatus(OrderStatus.shipped));
        model.addAttribute("acceptedCount", this.orderService.countByStatus(OrderStatus.accept));
        model.addAttribute("canceledCount", this.orderService.countByStatus(OrderStatus.canceled));
        return "admin/order/show";
    }

    @GetMapping("/accepted")
    public String getOrderAccept(Model model) {
        List<Order> orders = orderService.getOrderByStatus(OrderStatus.accept);
        Collections.reverse(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("status", "Accepted");
        model.addAttribute("pendingCount", this.orderService.countByStatus(OrderStatus.pending));
        model.addAttribute("shippingCount", this.orderService.countByStatus(OrderStatus.shipped));
        model.addAttribute("acceptedCount", this.orderService.countByStatus(OrderStatus.accept));
        model.addAttribute("canceledCount", this.orderService.countByStatus(OrderStatus.canceled));
        return "admin/order/show";
    }

    @GetMapping("/canceled")
    public String getOrderCancel(Model model) {
        List<Order> orders = orderService.getOrderByStatus(OrderStatus.canceled);
        Collections.reverse(orders);
        model.addAttribute("orders", orders);
        model.addAttribute("status", "Canceled");
        model.addAttribute("pendingCount", this.orderService.countByStatus(OrderStatus.pending));
        model.addAttribute("shippingCount", this.orderService.countByStatus(OrderStatus.shipped));
        model.addAttribute("acceptedCount", this.orderService.countByStatus(OrderStatus.accept));
        model.addAttribute("canceledCount", this.orderService.countByStatus(OrderStatus.canceled));
        return "admin/order/show";
    }

    // Cập nhật trạng thái đơn hàng
    @PostMapping("/update/{id}")
    public String updateOrderStatus(
            @PathVariable("id") Integer id) {
        Order order = this.orderService.getOrderById(id);
        if (order.getStatus() == OrderStatus.pending) {
            this.orderService.updateOrderStatus(id, OrderStatus.shipped);
        }
        return "redirect:/admin/order";
    }

    @GetMapping("/detail/{id}")
    public String viewOrderDetail(@PathVariable("id") Integer id, Model model) {
        Order order = orderService.getOrderById(id);
        if (order == null) {
            return "redirect:/admin/order";
        }

        // Lấy danh sách chi tiết sản phẩm trong đơn hàng
        List<OrderDetail> orderDetails = order.getOrderDetails();

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "admin/order/detail";
    }
}