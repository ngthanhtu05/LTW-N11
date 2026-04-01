package com.n11.sportshop.service;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        com.n11.sportshop.domain.User user = this.userService.getUserByUsername(username);
        /*
         * -> Mặc định của Spring Security lấy email làm username.
         * -> Nếu tự custom thì ta sẽ truyền username thay vì email.
         */
        if (user == null || user.getStatus() == 0) {
            throw new UsernameNotFoundException("Tài khoản không tồn tại");
        }
        /*
         * Tầng Service này sẽ kiểm tra xem tài khoản có trong database không
         * Nếu có sẽ gán quyền cho tài khoản đó (Ví dụ : ROLE_ADMIN)
         */
        return new User(
                user.getUsername(),
                user.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + user.getRole().getName())));
        /* Trả về username, password và role */
    }
}
