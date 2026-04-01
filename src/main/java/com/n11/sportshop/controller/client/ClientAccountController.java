package com.n11.sportshop.controller.client;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.n11.sportshop.domain.User;
import com.n11.sportshop.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ClientAccountController {

    private final UserService userService;

    public ClientAccountController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/profile")
    public String viewProfile(Authentication authentication, Model model) {
        String username = authentication.getName();
        User user = this.userService.getUserByUsername(username);
        model.addAttribute("user", user);
        return "client/user/show";
    }

    @GetMapping("/profile/update")
    public String getUpdateUserPage(Model model, Authentication authentication) {
        String username = authentication.getName();
        User user = this.userService.getUserByUsername(username);
        model.addAttribute("newUser", user);
        return "client/user/update";
    }

    @PostMapping("/profile/update")
    public String updateUserPage(
            @ModelAttribute("newUser") User user,
            BindingResult userBindingResult,
            @RequestParam("images") MultipartFile file,
            Authentication authentication,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        // Không cho update trùng username và email
        // User existingUser = userService.getUserByID(user.getId());
        // boolean emailChanged =
        // !user.getEmail().equalsIgnoreCase(existingUser.getEmail());
        // boolean usernameChanged =
        // !user.getUsername().equalsIgnoreCase(existingUser.getUsername());

        String phone = user.getPhoneNumber();

        // if (emailChanged && userService.checkEmailExist(user.getEmail())) {
        // userBindingResult.rejectValue("email", "error.user", "Email đã tồn tại");
        // }

        // if (usernameChanged && userService.checkUsernameExist(user.getUsername())) {
        // userBindingResult.rejectValue("username", "error.user", "Tên đăng nhập đã tồn
        // tại");
        // }

        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("^[0-9]{10}$")) {
                userBindingResult.rejectValue("phoneNumber", "error.user", "Số điện thoại phải gồm đúng 10 chữ số");
            }
        }

        if (userBindingResult.hasErrors()) {
            return "client/user/update";
        }

        User updateUser = this.userService.updateUser(user, file);
        session.setAttribute("fullName", updateUser.getFullName());
        session.setAttribute("avatar", updateUser.getImage());
        return "redirect:/profile";
    }
}
