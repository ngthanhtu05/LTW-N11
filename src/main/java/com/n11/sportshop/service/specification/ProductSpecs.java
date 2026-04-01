package com.n11.sportshop.service.specification;

import java.util.List;
import java.util.Locale.Category;

import org.springframework.data.jpa.domain.Specification;

import com.n11.sportshop.domain.Brand;
import com.n11.sportshop.domain.Brand_;
import com.n11.sportshop.domain.Category_;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.Product_;

import jakarta.persistence.criteria.Join;

public class ProductSpecs {

    public static Specification<Product> filterName(String name) {
        return (root, query, builder)
                -> builder.like(root.get(Product_.NAME), "%" + name + "%");
    }

    public static Specification<Product> filterCategories(List<String> codeCate) {
        return (root, query, builder)
                -> builder.in(root.get(Product_.category).get(Category_.CODE)).value(codeCate);
    }

    public static Specification<Product> filterPrice(Integer minPrice, Integer maxPrice) {
        int finalMinPrice, finalMaxPrice;
        if (minPrice == null) {
            finalMinPrice = 0;
        } else {
            finalMinPrice = minPrice;
        }
        if (maxPrice == null) {
            finalMaxPrice = 0;
        } else {
            finalMaxPrice = maxPrice;
        }
        return (root, query, builder)
                -> builder.between(root.get(Product_.PRICE), finalMinPrice, finalMaxPrice);
    }

    public static Specification<Product> onlyActiveBrandAndCategoryAndStatus() {
        return (root, query, cb) -> {
            Join<Product, Brand> brandJoin = root.join("brand");
            Join<Product, Category> categoryJoin = root.join("category");
            return cb.and(
                    cb.equal(brandJoin.get("status"), 1),
                    cb.equal(categoryJoin.get("status"), 1),
                    cb.equal(root.get(Product_.STATUS), 1)
            );
        };
    }

    public static Specification<Product> onlyActiveBrandAndCategory() {
        return (root, query, cb) -> {
            Join<Product, Brand> brandJoin = root.join("brand");
            Join<Product, Category> categoryJoin = root.join("category");
            return cb.and(
                    cb.equal(brandJoin.get("status"), 1),
                    cb.equal(categoryJoin.get("status"), 1)
            );
        };
    }

    public static Specification<Product> filterBrand(List<String> brandName) {
        return (root, query, builder)
                -> builder.in(root.get(Product_.BRAND).get(Brand_.NAME)).value(brandName);
    }
}
