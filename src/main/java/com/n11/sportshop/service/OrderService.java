package com.n11.sportshop.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.n11.sportshop.domain.CartDetail;
import com.n11.sportshop.domain.DiscountType;
import com.n11.sportshop.domain.Order;
import com.n11.sportshop.domain.OrderDetail;
import com.n11.sportshop.domain.OrderStatus;
import com.n11.sportshop.domain.PaymentMethod;
import com.n11.sportshop.domain.PaymentStatus;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.UserVoucher;
import com.n11.sportshop.domain.Voucher;
import com.n11.sportshop.domain.dto.InformationDTO;
import com.n11.sportshop.repository.CartDetailRepository;
import com.n11.sportshop.repository.CartRepository;
import com.n11.sportshop.repository.OrderDetailRepository;
import com.n11.sportshop.repository.OrderRepository;
import com.n11.sportshop.repository.ProductRepository;
import com.n11.sportshop.repository.UserRepository;
import com.n11.sportshop.repository.UserVoucherRepo;
import com.n11.sportshop.repository.VoucherRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrderService {

    private final CartRepository cartRepo;
    private final CartDetailRepository cartDetailRepo;
    private final OrderRepository orderRepo;
    private final OrderDetailRepository orderDetailRepo;
    private final UserRepository userRepository;
    private final CartService cartService;
    private final ProductRepository productRepository;
    private final VoucherRepository voucherRepository;
    private final UserVoucherRepo userVoucherRepo;

    public OrderService(UserVoucherRepo userVoucherRepo, CartDetailRepository cartDetailRepo, CartRepository cartRepo,
            CartService cartService, OrderDetailRepository orderDetailRepo, OrderRepository orderRepo,
            ProductRepository productRepository, UserRepository userRepository, VoucherRepository voucherRepository) {
        this.cartDetailRepo = cartDetailRepo;
        this.cartRepo = cartRepo;
        this.cartService = cartService;
        this.orderDetailRepo = orderDetailRepo;
        this.orderRepo = orderRepo;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.voucherRepository = voucherRepository;
        this.userVoucherRepo = userVoucherRepo;
    }

    public List<Order> getOrderHistoryByStatus(User user, OrderStatus status) {
        return orderRepo.findByUserAndStatus(user, status);
    }

    public List<Order> getOrderByStatus(OrderStatus status) {
        return this.orderRepo.findByStatus(status);
    }

    @Transactional
    public Order createOrder(Integer userId, String voucherCode, InformationDTO informationDTO) {
        User user = this.userRepository.findById(userId).get();
        List<CartDetail> items = this.cartService.getCartDetails(user);
        Order order = new Order();
        order.setUser(user);
        order.setName(informationDTO.getName());
        order.setEmail(informationDTO.getEmail());
        order.setAddress(informationDTO.getAddress());
        order.setNote(informationDTO.getNote());
        order.setPhone(informationDTO.getPhone());
        order.setStatus(OrderStatus.pending);
        order.setPaymentStatus(PaymentStatus.UNPAID);
        order.setCreateAt(LocalDateTime.now());
        order.setExpiredTime(order.getCreateAt().plusMinutes(5));

        if (informationDTO.getPayment().equals("CASH")) {
            order.setPaymentMethod(PaymentMethod.CASH);
        } else {
            order.setPaymentMethod(PaymentMethod.VNPAY);
            order.setPaymentRef(informationDTO.getPaymentRef());
        }
        order = this.orderRepo.save(order);

        Long price = 0L;
        Long shipPrice = 30000L;
        Long discountAmount = 0L;

        for (var item : items) {
            // Khóa hàng lại để tránh 2 người mua cùng lúc
            Product product = this.productRepository.findByIdForUpdate(item.getProduct().getId()).get();

            if (product.getStockQuantity() == 0 || product.getStockQuantity() < item.getQuantity()) {
                throw new RuntimeException("Kho không còn đủ số lượng");
            }

            product.setStockQuantity(product.getStockQuantity() - item.getQuantity());
            this.productRepository.save(product);

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProduct(product);
            orderDetail.setOrder(order);
            orderDetail.setPrice(product.getPrice());
            orderDetail.setQuantity(item.getQuantity());
            this.orderDetailRepo.save(orderDetail);

            price += item.getQuantity() * product.getPrice();
        }

        if (!voucherCode.equals("NONE")) {
            Voucher voucher = this.voucherRepository.findByCode(voucherCode);
            UserVoucher userVoucher = this.userVoucherRepo.findByUserAndVoucher(user, voucher);

            order.setVoucher(voucher);
            this.userVoucherRepo.delete(userVoucher);

            if (voucher.getDiscountType() == DiscountType.freeship) {
                shipPrice = 0L;
            } else if (voucher.getDiscountType() == DiscountType.fixed_amount) {
                discountAmount = voucher.getDiscountValue() * 1L;
            } else {
                discountAmount = price * voucher.getDiscountValue() / 100;
            }
        }

        order.setTotalAmount(price);
        order.setShipPrice(shipPrice);
        order.setDiscountAmount(discountAmount);
        return order;
    }

    public List<OrderDetail> getOrderDetails(User user) {
        Order order = this.orderRepo.findTopByUserOrderByIdDesc(user);
        return this.orderDetailRepo.findByOrder(order);
    }

    // lay toan bo don hang
    public List<Order> getAllOrders() {
        return orderRepo.findAll();
    }

    // Cap nhat trang thai trong admin/order
    @Transactional
    public void updateOrderStatus(Integer orderId, OrderStatus status) {
        Order order = orderRepo.findById(orderId).get();
        order.setStatus(status);
        if (order.getStatus() == OrderStatus.accept)
            order.setPaymentStatus(PaymentStatus.PAID);
        orderRepo.save(order);
    }

    @Transactional
    public void deleteOrder(Order order) {
        this.orderDetailRepo.deleteByOrder(order);
        this.orderRepo.deleteById(order.getId());
    }

    public Order getOrderByUser(User user) {
        return this.orderRepo.findTopByUserOrderByIdDesc(user);
    }

    public Order getOrderById(int id) {
        return this.orderRepo.findById(id).get();
    }

    public Integer countByStatus(OrderStatus status) {
        return this.orderRepo.countByStatus(status);
    }

    public Order getOrderByPaymentRef(String paymentRef) {
        return this.orderRepo.findByPaymentRef(paymentRef);
    }
    public long countAllOrders() {
        return orderRepo.count();
    }
    public Long getTotalSales() {
        Long total = orderRepo.getTotalSales();
        return total != null ? total : 0L;
    }

}
