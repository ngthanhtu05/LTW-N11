package com.n11.sportshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.n11.sportshop.domain.Brand;
import com.n11.sportshop.domain.Product;

import jakarta.persistence.criteria.Join;

public class ProductSpecs {

    public static Specification<Product> filterName(String name) {
        return (root, query, builder)
                -> builder.like(root.get("name"), "%" + name + "%");
    }

    public static Specification<Product> filterCategories(List<String> codeCate) {
        return (root, query, builder)
                -> root.get("category").get("code").in(codeCate);
    }

    public static Specification<Product> filterPrice(Integer minPrice, Integer maxPrice) {
        int finalMinPrice = (minPrice == null) ? 0 : minPrice;
        int finalMaxPrice = (maxPrice == null) ? Integer.MAX_VALUE : maxPrice;

        return (root, query, builder)
                -> builder.between(root.get("price"), finalMinPrice, finalMaxPrice);
    }

    public static Specification<Product> onlyActiveBrandAndCategoryAndStatus() {
        return (root, query, cb) -> {
            Join<Product, Brand> brandJoin = root.join("brand");
            Join<Product, ?> categoryJoin = root.join("category");

            return cb.and(
                    cb.equal(brandJoin.get("status"), 1),
                    cb.equal(categoryJoin.get("status"), 1),
                    cb.equal(root.get("status"), 1)
            );
        };
    }

    public static Specification<Product> onlyActiveBrandAndCategory() {
        return (root, query, cb) -> {
            Join<Product, Brand> brandJoin = root.join("brand");
            Join<Product, ?> categoryJoin = root.join("category");

            return cb.and(
                    cb.equal(brandJoin.get("status"), 1),
                    cb.equal(categoryJoin.get("status"), 1)
            );
        };
    }

    public static Specification<Product> filterBrand(List<String> brandName) {
        return (root, query, builder)
                -> root.get("brand").get("name").in(brandName);
    }
}