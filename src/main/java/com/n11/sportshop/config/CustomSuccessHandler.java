package com.n11.sportshop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.dto.RegisterDTO;
import com.n11.sportshop.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    protected String determineTargetUrl(Authentication authentication) {

        Map<String, String> map = new HashMap<>();
        map.put("ROLE_USER", "/");
        map.put("ROLE_ADMIN", "/admin");

        for (GrantedAuthority auth : authentication.getAuthorities()) {
            if (map.containsKey(auth.getAuthority())) {
                return map.get(auth.getAuthority());
            }
        }
        return "/";
    }

    protected void clearAuthenticationAttributes(
            HttpServletRequest request,
            Authentication authentication) {

        HttpSession session = request.getSession(true);
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);

        Object principal = authentication.getPrincipal();

        String email = null;
        String name = null;
        String avatar = null;
        boolean isGoogle = false;

        // ===== GOOGLE LOGIN =====
        if (principal instanceof OAuth2User oauth) {
            email = oauth.getAttribute("email");
            name = oauth.getAttribute("name");
            avatar = oauth.getAttribute("picture");
            isGoogle = true;
        }

        // ===== NORMAL LOGIN =====
        else if (principal instanceof UserDetails userDetails) {
            email = userDetails.getUsername();
        }

        if (email == null) return;

        User user = userService.getUserByUsername(email);

        if (user == null && isGoogle) {

            RegisterDTO dto = new RegisterDTO();

            String fullName = (name != null) ? name : email.split("@")[0];

            dto.setFirstName(fullName);
            dto.setLastName("");
            dto.setUsername(email);
            dto.setEmail(email);

            // password fake (không dùng login)
            String fakePassword = "GOOGLE_" + System.currentTimeMillis();
            dto.setPassword(fakePassword);
            dto.setConfirmPassword(fakePassword);

            userService.createUserByClient(dto);

            user = userService.getUserByUsername(email);
        }

        if (user == null) return;

        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("id", user.getId());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("avatar", user.getImage());
    }

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication)
            throws IOException, ServletException {

        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) return;

        clearAuthenticationAttributes(request, authentication);
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
}