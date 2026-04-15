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

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/api/products")
@Tag(name = "Product REST API", description = "API lấy dữ liệu sản phẩm ở dạng JSON")
public class ProductApiController {

    private final ProductService productService;

    public ProductApiController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    @Operation(
            summary = "Lấy danh sách sản phẩm",
            description = "Trả về danh sách tất cả sản phẩm hiện có.")
    @ApiResponse(responseCode = "200", description = "Lấy danh sách sản phẩm thành công")
    public List<ProductResponse> getAllProducts() {
        return this.productService.getAllProducts()
                .stream()
                .map(this::toResponse)
                .toList();
    }

    @GetMapping("/{id}")
    @Operation(
            summary = "Lấy chi tiết sản phẩm theo ID",
            description = "Trả về thông tin chi tiết của một sản phẩm.")
    @ApiResponse(responseCode = "200", description = "Tìm thấy sản phẩm")
    @ApiResponse(responseCode = "404", description = "Không tìm thấy sản phẩm")
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
            @Schema(example = "1") int id,
            @Schema(example = "Nike Air Zoom") String name,
            @Schema(example = "Giày chạy bộ chuyên dụng") String description,
            @Schema(example = "2499000") Long price,
            @Schema(example = "12") int stockQuantity,
            @Schema(example = "SHO50.jpg") String image,
            @Schema(example = "1") Integer status,
            CategorySummary category,
            BrandSummary brand) {
    }

    public record CategorySummary(
            @Schema(example = "2") int id,
            @Schema(example = "SHO") String code,
            @Schema(example = "Shoes") String name,
            @Schema(example = "1") Integer status) {
    }

    public record BrandSummary(
            @Schema(example = "3") int id,
            @Schema(example = "Nike") String name,
            @Schema(example = "1") Integer status) {
    }
}
