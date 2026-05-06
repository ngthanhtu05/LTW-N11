package com.n11.sportshop.service;

import org.springframework.stereotype.Service;

import com.n11.sportshop.domain.User;

import jakarta.servlet.http.HttpSession;

@Service
public class AuthSessionService {

    public void applyUserSession(HttpSession session, User user) {
        if (session == null || user == null) {
            return;
        }
        session.setAttribute("fullName", user.getFullName());
        session.setAttribute("id", user.getId());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("avatar", user.getImage());
    }

    public void clearUserSession(HttpSession session) {
        if (session == null) {
            return;
        }
        session.removeAttribute("fullName");
        session.removeAttribute("id");
        session.removeAttribute("email");
        session.removeAttribute("avatar");
    }
}
