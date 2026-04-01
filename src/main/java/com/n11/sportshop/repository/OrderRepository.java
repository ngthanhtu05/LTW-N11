package com.n11.sportshop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.n11.sportshop.domain.Order;
import com.n11.sportshop.domain.OrderStatus;
import com.n11.sportshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order,Integer>{
    List<Order> findByUser (User user);
    Order findTopByUserOrderByIdDesc(User user);
    List<Order> findByStatus(OrderStatus status);
    List<Order> findByUserAndStatus(User user, OrderStatus status);
    Integer countByStatus(OrderStatus status);
    Order findByPaymentRef(String paymentRef);
    @Query(value = "SELECT * FROM orders o WHERE o.payment_status = 'UNPAID' AND o.payment_method = 'VNPAY' AND o.expired_time < :now", nativeQuery = true)
    List<Order> findExpiredUnpaidOrders(@Param("now") LocalDateTime now);
    @Query("""
        SELECT SUM(o.totalAmount + o.shipPrice - o.discountAmount)
        FROM Order o
        WHERE o.status = com.n11.sportshop.domain.OrderStatus.accept
        """)
    Long getTotalSales();

}
