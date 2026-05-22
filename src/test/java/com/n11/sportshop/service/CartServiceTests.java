package com.n11.sportshop.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.n11.sportshop.domain.Cart;
import com.n11.sportshop.domain.CartDetail;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.repository.CartDetailRepository;
import com.n11.sportshop.repository.CartRepository;
import com.n11.sportshop.repository.ProductRepository;

@ExtendWith(MockitoExtension.class)
class CartServiceTests {

    @Mock
    private CartRepository cartRepository;

    @Mock
    private CartDetailRepository cartDetailRepository;

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private CartService cartService;

    @Test
    void updateCartUsesActiveCartStatus() {
        User user = new User();
        Cart cart = new Cart();
        Product product = new Product();
        CartDetail cartDetail = new CartDetail();

        when(cartRepository.findByUserAndStatus(user, "active")).thenReturn(Optional.of(cart));
        when(productRepository.findById(7)).thenReturn(Optional.of(product));
        when(cartDetailRepository.findByCartAndProduct(cart, product)).thenReturn(cartDetail);

        cartService.updateCart(user, 7, 3);

        assertEquals(3, cartDetail.getQuantity());
        verify(cartRepository, never()).save(cart);
        verify(cartDetailRepository).save(cartDetail);
    }
}
