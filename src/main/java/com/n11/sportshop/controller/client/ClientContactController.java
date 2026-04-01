package com.n11.sportshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class ClientContactController {
    @GetMapping("/contact")
    public String getContactPage(Model model) {
        return "client/contact/show";
    }
    
}
