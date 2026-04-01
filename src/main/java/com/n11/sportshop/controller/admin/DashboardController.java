package com.n11.sportshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.n11.sportshop.service.OrderService;
import com.n11.sportshop.service.ProductService;
import com.n11.sportshop.service.UserService;



@Controller
@RequestMapping("/admin")
public class DashboardController {
    private final UserService userService;
    private final OrderService orderService;
    private final ProductService productService;

    

    public DashboardController(UserService userService, OrderService orderService, ProductService productService) {
        this.userService = userService;
        this.orderService = orderService;
        this.productService = productService;
    }



    @GetMapping
    public String getDashBoardPage(Model model) {
        long activeUserCount = userService.countActiveUsers();
        long orderCount = orderService.countAllOrders();
        long productCount = productService.countActiveProductsWithActiveCategoryAndBrand();
        long totalSales = orderService.getTotalSales();
        model.addAttribute("activeUserCount", activeUserCount);
        model.addAttribute("orderCount", orderCount);
        model.addAttribute("productCount", productCount);
        model.addAttribute("totalSales",totalSales);
        return "admin/dashboard/show";
    }

    
}
 