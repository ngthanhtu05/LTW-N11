package com.n11.sportshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.n11.sportshop.domain.Brand;
import com.n11.sportshop.domain.PaginationQuery;
import com.n11.sportshop.domain.Product;
import com.n11.sportshop.repository.BrandRepository;
import com.n11.sportshop.service.ImageService;
import com.n11.sportshop.service.PaginationService;
import com.n11.sportshop.service.ProductService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin/product")
public class ProductController {

    private final BrandRepository brandRepository;

    private final ProductService productService;
    private final ImageService imageService;
    private final PaginationService paginationServie;

    public ProductController(ProductService productService, ImageService imageService,
            PaginationService paginationServie, BrandRepository brandRepository) {
        this.productService = productService;
        this.imageService = imageService;
        this.paginationServie = paginationServie;
        this.brandRepository = brandRepository;
    }

    // hien thi danh sach san pham
    @GetMapping
    public String getProductPage(Model model, @RequestParam("page") Optional<String> pageOptinal) {

        PaginationQuery<Product> paginationQuery = this.paginationServie.AdminProductPagination(pageOptinal, 8);

        // --------------- Lấy tất cả sản phẩm-------------------
        model.addAttribute("products", paginationQuery.getPrs().getContent());

        // --------------Lấy STT trang hiện tại-------------------
        model.addAttribute("currentPage", paginationQuery.getPage());

        // ---------------Lấy tổng số trang ------------------
        model.addAttribute("totalPage", paginationQuery.getPrs().getTotalPages());

        model.addAttribute("newProduct", new Product());
        return "admin/product/show";
    }

    // hien thi form moi
    @GetMapping("/create")
    public String getProductCreatePage(Model model) {
        model.addAttribute("newProduct", new Product());
        model.addAttribute("brand", new Brand());
        model.addAttribute("categories", this.productService.getAllCategories());
        model.addAttribute("brands", this.productService.getAllBrands());
        return "admin/product/create";
    }

    // Xử lý lưu sản phẩm mới
    @PostMapping("/create")
    public String postCreateProduct(
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult productBindingResult,
            @RequestParam("images") MultipartFile file, Model model) {

        // Dùng để debug validate
        List<FieldError> errors = productBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>>" + error.getObjectName() + " - " + error.getDefaultMessage());
        }

        // Kiểm tra tên sản phẩm đã tồn tại hay chưa
        if (productService.existsByName(product.getName())) {
            productBindingResult.rejectValue("name", "error.product", "Tên sản phẩm đã tồn tại");
        }

        // Validate trả lỗi về màn hình trang product create
        if (productBindingResult.hasErrors() == true) {
            model.addAttribute("categories", this.productService.getAllCategories());
            model.addAttribute("brands", this.productService.getAllBrands());
            return "admin/product/create";
        }

        this.productService.saveProduct(product, file);
        return "redirect:/admin/product";
    }

    // Hiển thị chi tiết 1 sản phẩm
    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") int id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm ID = " + id));
        model.addAttribute("product", product);
        return "admin/product/detail"; // file HTML hiển thị chi tiết
    }

    // Xóa sản phẩm
    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm ID = " + id));
        productService.deleteById(id);
        imageService.deleteImage(product.getImage(), "product");
        return "redirect:/admin/product";
    }

    // Sửa sản phẩm (hiển thị form)
    @GetMapping("/update/{id}")
    public String editProductForm(@PathVariable("id") int id, Model model) {
        Product product = productService.getProductById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm ID = " + id));
        model.addAttribute("categories", this.productService.getAllCategories());
        model.addAttribute("brands", this.productService.getAllBrands());
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    // Cập nhật sản phẩm
    @PostMapping("/update")
    public String updateProduct(
            @ModelAttribute("product") Product product,
            @RequestParam("images") MultipartFile file) {
        this.productService.saveProduct(product, file);
        return "redirect:/admin/product";
    }
    @PostMapping("/toggle/{id}")
    public String postCreateProduct(@PathVariable("id") Integer id) {
        this.productService.actionProduct(id);
        return "redirect:/admin/product";
    }
}
