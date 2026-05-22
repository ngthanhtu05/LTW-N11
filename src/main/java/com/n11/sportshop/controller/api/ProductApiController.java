package com.n11.sportshop.controller.api;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.n11.sportshop.domain.Brand;
import com.n11.sportshop.domain.Category;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.service.ProductService;

@RestController
@RequestMapping("/api/products")
public class ProductApiController {

    private final ProductService productService;

    public ProductApiController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public List<ProductResponse> getAllProducts() {
        return this.productService.getAllProducts()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponse> getProductById(@PathVariable("id") int id) {
        return this.productService.getProductById(id)
                .map(this::toResponse)
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    private ProductResponse toResponse(Product product) {
        CategorySummary categorySummary = toCategorySummary(product.getCategory());
        BrandSummary brandSummary = toBrandSummary(product.getBrand());
        return new ProductResponse(
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getPrice(),
                product.getStockQuantity(),
                product.getImage(),
                product.getStatus(),
                categorySummary,
                brandSummary);
    }

    private CategorySummary toCategorySummary(Category category) {
        if (category == null) {
            return null;
        }
        return new CategorySummary(
                category.getId(),
                category.getCode(),
                category.getName(),
                category.getStatus());
    }

    private BrandSummary toBrandSummary(Brand brand) {
        if (brand == null) {
            return null;
        }
        return new BrandSummary(
                brand.getId(),
                brand.getName(),
                brand.getStatus());
    }

    public record ProductResponse(
            int id,
            String name,
            String description,
            Long price,
            int stockQuantity,
            String image,
            Integer status,
            CategorySummary category,
            BrandSummary brand) {
    }

    public record CategorySummary(
            int id,
            String code,
            String name,
            Integer status) {
    }

    public record BrandSummary(
            int id,
            String name,
            Integer status) {
    }
}
