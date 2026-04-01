package com.n11.sportshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.n11.sportshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer>, JpaSpecificationExecutor<Product> {

    Page<Product> findAll(Pageable pageable);

    Page<Product> findAll(Specification<Product> specification, Pageable pageable);

    boolean existsByName(String name);

    List<Product> findTop8ByOrderByIdDesc();

    @Query(value = "SELECT * FROM product WHERE id = :id FOR UPDATE", nativeQuery = true)
    Optional<Product> findByIdForUpdate(@Param("id") Integer id);

    @Query(value = """
    SELECT p.* 
    FROM product p
    JOIN brand b ON p.brand_id = b.id
    JOIN category c ON c.id = p.category_id
    WHERE b.status = 1
      AND c.status = 1
    """, nativeQuery = true)
    List<Product> findActiveProduct();

    List<Product> findByStatus(Integer status);

    @Modifying
    @Query(value = "UPDATE product SET stock_quantity = stock_quantity - :quantity WHERE id = :id AND stock_quantity >= :quantity", nativeQuery = true)
    int reduceStock(@Param("id") Long id, @Param("quantity") int quantity);
    @Query(value = """
        SELECT COUNT(*) 
        FROM product p
        JOIN brand b ON p.brand_id = b.id
        JOIN category c ON c.id = p.category_id
        WHERE p.status = 1
          AND b.status = 1
          AND c.status = 1
        """, nativeQuery = true)
    long countActiveProductsWithActiveCategoryAndBrand();
}
