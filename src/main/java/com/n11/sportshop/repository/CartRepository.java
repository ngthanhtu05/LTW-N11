package com.n11.sportshop.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.n11.sportshop.domain.Cart;
import com.n11.sportshop.domain.User;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {
    Optional<Cart> findByUserAndStatus(User user, String status);
    void deleteByUser(User user);
}

