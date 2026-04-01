package com.n11.sportshop.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.n11.sportshop.domain.PaginationQuery;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.dto.ProductCriteriaDTO;
import com.n11.sportshop.repository.ProductRepository;
import com.n11.sportshop.service.specification.ProductSpecs;

@Service
public class PaginationService {

    private final UserService userService;
    private final ProductService productService;
    private final ProductRepository productRepository;

    public PaginationService(ProductRepository productRepository, ProductService productService,
            UserService userService) {
        this.productRepository = productRepository;
        this.productService = productService;
        this.userService = userService;
    }

    public PaginationQuery<Product> AdminProductPagination(Optional<String> pageOptinal, int size) {
        Specification<Product> combineSpecs = Specification.where(ProductSpecs.onlyActiveBrandAndCategory());
        // pageOptinal chứa số thứ tự trang do client truyền lên (có thể null hoặc rỗng)
        // size :Số lượng sản phẩm hiển thị trên mỗi trang
        int page = 1; // Mặc định nếu client không truyền số trang thì sẽ hiển thị trang đầu tiên
        // ?page = 1&name=acb
        try {
            // Nếu client có truyền số trang (ví dụ ?page=2) → parse từ String sang int
            if (pageOptinal.isPresent()) {
                page = Integer.parseInt(pageOptinal.get());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Pageable: đại diện cho thông tin phân trang mà Spring Data JPA sử dụng
        // page - 1 vì trong Spring Data JPA, số trang bắt đầu từ 0 (0 = trang 1, 1 =
        // trang 2, ...)
        Pageable pageable = PageRequest.of(page - 1, size);
        // 1 trang luu size sanr pham;
        // fetchProducts(pageable) trả về một Page<Product> gồm danh sách sản phẩm +
        // tổng số trang + tổng số phần tử
        Page<Product> prs = this.productRepository.findAll(combineSpecs, pageable);

        return new PaginationQuery<>(page, prs);
    }

    public PaginationQuery<User> AdminUserPagination(Optional<String> pageOptinal, int size) {
        int page = 1;

        try {
            if (pageOptinal.isPresent()) {
                page = Integer.parseInt(pageOptinal.get());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Pageable pageable = PageRequest.of(page - 1, size);
        Page<User> prs = this.userService.fetchUsers(pageable);

        return new PaginationQuery<>(page, prs);
    }

    public Page<Product> ClientProductsPagination(ProductCriteriaDTO productCriteriaDTO) {
        Specification<Product> combineSpecs = Specification.where(ProductSpecs.onlyActiveBrandAndCategoryAndStatus());
        int page = 1;

        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = productCriteriaDTO.getPage().get();
            }
        } catch (Exception e) {
            productCriteriaDTO.setPage(Optional.of(1));
            e.printStackTrace();
        }

        Pageable pageable = PageRequest.of(page - 1, 9, Sort.by("name").ascending());
        if (productCriteriaDTO.getBrand() == null
                && productCriteriaDTO.getCategories() == null
                && productCriteriaDTO.getMinPrice() == null
                && productCriteriaDTO.getMaxPrice() == null) {
            return this.productRepository.findAll(combineSpecs, pageable);
        } else {
            if (productCriteriaDTO.getBrand() != null && productCriteriaDTO.getBrand().isPresent()) {
                combineSpecs = combineSpecs.and(ProductSpecs.filterBrand(productCriteriaDTO.getBrand().get()));
            }
            if (productCriteriaDTO.getCategories() != null && productCriteriaDTO.getCategories().isPresent()) {
                combineSpecs = combineSpecs
                        .and(ProductSpecs.filterCategories(productCriteriaDTO.getCategories().get()));
            }

            if (productCriteriaDTO.getMinPrice() != null || productCriteriaDTO.getMaxPrice() != null) {
                combineSpecs = combineSpecs.and(ProductSpecs.filterPrice(productCriteriaDTO.getMinPrice().get(),
                        productCriteriaDTO.getMaxPrice().get()));
            }

            return this.productRepository.findAll(combineSpecs, pageable);
        }
    }
}
