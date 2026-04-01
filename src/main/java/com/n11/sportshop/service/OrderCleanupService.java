package com.n11.sportshop.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.n11.sportshop.domain.Order;
import com.n11.sportshop.repository.OrderDetailRepository;
import com.n11.sportshop.repository.OrderRepository;

@Service
public class OrderCleanupService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderCleanupService(OrderDetailRepository orderDetailRepository, OrderRepository orderRepository) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
    }

    

    @Scheduled(fixedRate = 60000)
    
    public void cleanupUnpaidOrders() {
        LocalDateTime now = LocalDateTime.now();
        List<Order> expiredOrders = this.orderRepository.findExpiredUnpaidOrders(now);

        for (Order order : expiredOrders) {
            this.orderDetailRepository.deleteByOrder(order);
            orderRepository.delete(order);
        }
    }
}
