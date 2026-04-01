package com.n11.sportshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.n11.sportshop.domain.Cart;
import com.n11.sportshop.domain.CartDetail;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.repository.CartDetailRepository;
import com.n11.sportshop.repository.CartRepository;
import com.n11.sportshop.repository.ProductRepository;

import jakarta.transaction.Transactional;

@Service
public class CartService {
    private final CartRepository cartRepo;
    private final CartDetailRepository cartDetailRepo;
    private final ProductRepository productRepo;


    public CartService(CartDetailRepository cartDetailRepo, CartRepository cartRepo, ProductRepository productRepo) {
        this.cartDetailRepo = cartDetailRepo;
        this.cartRepo = cartRepo;
        this.productRepo = productRepo;
    }

    public Cart getActiveCart(User user) {
        return cartRepo.findByUserAndStatus(user, "active")
                .orElseGet(() -> {
                    Cart cart = new Cart();
                    cart.setUser(user);
                    cart.setStatus("active");
                    return cartRepo.save(cart);
                });
    }

    public void addToCart(User user, int productId, int quantity) {
        Cart cart = getActiveCart(user);
        Product product = this.productRepo.findById(productId).orElseThrow();

        CartDetail item = this.cartDetailRepo.findByCartAndProduct(cart, product);
        if (item == null) {
            item = new CartDetail();
        }
        item.setCart(cart);
        item.setProduct(product);
        item.setQuantity(item.getQuantity() + quantity);
        
        cartDetailRepo.save(item);
    }

    public List<CartDetail> getCartDetails(User user) {
        return cartDetailRepo.findByCart(getActiveCart(user));
    }

    public void updateCart (User user, Integer productId, Integer quantity) {
        Cart cart = this.cartRepo.findByUserAndStatus(user, "ACTIVE").get();
        Product product = this.productRepo.findById(productId).get();
        CartDetail cartDetail = this.cartDetailRepo.findByCartAndProduct(cart, product);
        cartDetail.setQuantity(quantity);
        this.cartDetailRepo.save(cartDetail);
    }

    public void deleteItemInCart(int id) {
        this.cartDetailRepo.deleteById(id);
    }

    @Transactional
    public void deleteCart(User user, Cart cart) {
        this.cartDetailRepo.deleteByCart(cart);
        this.cartRepo.deleteByUser(user);
    }
}
