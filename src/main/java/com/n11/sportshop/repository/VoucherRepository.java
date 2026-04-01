package com.n11.sportshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.n11.sportshop.domain.Voucher;



@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Integer>{
    Voucher findByCode(String code);
    List<Voucher> findByStatus(Integer status);
}
