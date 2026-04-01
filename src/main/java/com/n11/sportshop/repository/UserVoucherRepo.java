package com.n11.sportshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.UserVoucher;
import com.n11.sportshop.domain.Voucher;

@Repository
public interface UserVoucherRepo extends JpaRepository<UserVoucher, Integer> {

    @Query(value = """
    SELECT uv.* 
    FROM user_voucher uv
    JOIN users u ON u.id = uv.user_id
    JOIN voucher v ON v.id = uv.voucher_id
    WHERE v.status = :status 
      AND uv.quantity >= :quantity 
      AND u.id = :userId
    """, nativeQuery = true)
    List<UserVoucher> findByUserAndStatusAndQuantityGreaterThan(
            @Param("userId") Integer userId,
            @Param("status") Integer status,
            @Param("quantity") Integer quantity
    );

    UserVoucher findByUserAndVoucher(User user, Voucher voucher);

    List<UserVoucher> findByUser(User user);

    boolean existsByUserAndVoucher(User user, Voucher voucher);

}
