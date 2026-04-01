<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:setLocale value="vi_VN" />
                <fmt:setBundle basename="messages" />

                <!-- Start Header Area -->
                <jsp:include page="../layout/header.jsp" />
                <!-- End Header Area -->
                <style>
                    .pagination .page-link {
                        color: #ffba00;
                        border-color: #ffba00;
                    }

                    .pagination .page-item.active .page-link {
                        background-color: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);

                        color: #fff;
                        border-color: #ffba00;
                    }

                    .product-badge {
                        position: absolute;

                        top: 15px;

                        left: 15px;

                        color: white;
                        padding: 3px 6px;
                        font-size: 8px;
                        font-weight: 500;
                        border-radius: 4px;
                        z-index: 10;
                        text-transform: uppercase;
                    }


                    .product-badge.badge-stock {
                        background: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);


                    }

                    .product-badge.badge-out-of-stock {
                        background-color: #dc3545;

                    }
                </style>

                <!-- Start Banner Area -->
                <section class="banner-area organic-breadcrumb">
                    <div class="container">
                        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
                            <div class="col-first">
                                <h1>Shop Category page</h1>

                            </div>
                        </div>
                    </div>
                </section>
                <!-- End Banner Area -->
                <div class="container">
                    <div class="row" style="margin-bottom: 100px; margin-top: 100px;">
                        <div class="col-xl-3 col-lg-4 col-md-5">
                            <div class="sidebar-filter mt-50" style="margin-top: 0px;">
                                <div class="top-filter-head">Product Filters</div>
                                <div class="common-filter">
                                    <div class="head">Categories</div>
                                    <ul>
                                        <c:forEach var="category" items="${categories}">
                                            <li class="filter-list">
                                                <div class="cateFilter">
                                                    <input class="form-check-input" type="checkbox" name="categories"
                                                        id="category-${category.id}" value="${category.code}" <c:if
                                                        test="${criteria.categories.present && criteria.categories.get().contains(category.code)}">checked
                                                    </c:if>
                                                    >
                                                    <label for="category-${category.id}">${category.name}</label>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <div class="head">Brands</div>
                                    <ul>
                                        <c:forEach var="brand" items="${brands}">
                                            <li class="filter-list">
                                                <div class="brandFilter">
                                                    <input class="form-check-input" type="checkbox" name="brand"
                                                        id="brand-${brand.id}" value="${brand.name}" <c:if
                                                        test="${criteria.brand.present && criteria.brand.get().contains(brand.name)}">checked
                                                    </c:if>
                                                    >
                                                    <label for="brand-${brand.id}">${brand.name}</label>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>

                                <!-- Lọc theo giá -->

                                <!-- Nút lọc -->
                                <div class="text-center mt-3">
                                    <button id="btnFilter" type="button" class="primary-btn w-100">
                                        Lọc sản phẩm
                                    </button>
                                </div>
                            </div>


                        </div>


                        <div class="col-xl-9 col-lg-8 col-md-7">
                            <!-- Start Filter Bar -->

                            <div class="filter-bar d-flex flex-wrap align-items-center justify-content-end">
                                <!-- ------------------Phân trang----------------------------- -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <li class="${1 eq currentPage ? 'page-item disabled' : 'page-item'}">
                                            <a class="page-link" href="/products?page=${currentPage - 1}"
                                                aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>

                                        <!-- Hiển thị chỉ vài số quanh trang hiện tại -->
                                        <c:forEach begin="1" end="${totalPage}" varStatus="loop">
                                            <c:if
                                                test="${loop.index >= currentPage - 2 && loop.index <= currentPage + 2}">
                                                <li class="page-item">
                                                    <a class="${loop.index eq currentPage ? 'active page-link' : 'page-link'}"
                                                        href="/products?page=${loop.index}${queryString}">
                                                        ${loop.index}
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <li class="${totalPage eq currentPage ? 'page-item disabled' : 'page-item'}">
                                            <a class="page-link" href="/products?page=${currentPage + 1}"
                                                aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- End Filter Bar -->
                            <!-- Start Best Seller -->
                            <section class="lattest-product-area pb-40 category-list">
                                <div class="row">
                                    <!-- single product -->
                                    <c:forEach var="product" items="${products}">
                                        <div class="col-lg-4 col-md-6">
                                            <div class="single-product">
                                                <c:choose>

                                                    <c:when test="${product.stockQuantity > 0}">
                                                        <span class="product-badge badge-stock">Còn hàng</span>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <span class="product-badge badge-out-of-stock">Còn cái
                                                            nịt</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <img class="img-fluid" src="/images/product/${product.image}" alt=""
                                                    style="height: 255px;">
                                                <div class="product-details">
                                                    <a href="/products/${product.id}">
                                                        <h6>${product.name}</h6>
                                                    </a>
                                                    <div class="price">

                                                        <fmt:formatNumber value="${product.price}" type="currency" />

                                                    </div>
                                                    <div class="prd-bottom">
                                                        <c:choose>

                                                            <c:when test="${product.stockQuantity > 0}">
                                                                <form
                                                                    action="/products/add-product-to-cart/${product.id}"
                                                                    method="post" class="d-inline">
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                        value="${_csrf.token}" />
                                                                    <a href="#" class="social-info"
                                                                        onclick="this.closest('form').submit(); return false;">
                                                                        <span class="ti-bag"></span>
                                                                        <p class="hover-text">add to bag</p>
                                                                    </a>
                                                                </form>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <a class="social-info">
                                                                    <span class="ti-close"></span>

                                                                    <p class="hover-text">Hết hàng</p>
                                                                </a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </section>
                            <!-- End Best Seller -->
                            <!-- Start Filter Bar -->
                            <div class="filter-bar d-flex flex-wrap align-items-center justify-content-end">
                                <!-- ------------------Phân trang----------------------------- -->
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination">
                                        <li class="${1 eq currentPage ? 'page-item disabled' : 'page-item'}">
                                            <a class="page-link" href="/products?page=${currentPage - 1}"
                                                aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>

                                        <!-- Hiển thị chỉ vài số quanh trang hiện tại -->
                                        <c:forEach begin="1" end="${totalPage}" varStatus="loop">
                                            <c:if
                                                test="${loop.index >= currentPage - 2 && loop.index <= currentPage + 2}">
                                                <li class="page-item">
                                                    <a class="${loop.index eq currentPage ? 'active page-link' : 'page-link'}"
                                                        href="/products?page=${loop.index}${queryString}">
                                                        ${loop.index}
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <li class="${totalPage eq currentPage ? 'page-item disabled' : 'page-item'}">
                                            <a class="page-link" href="/products?page=${currentPage + 1}"
                                                aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>

                            <!-- End Filter Bar -->
                        </div>
                    </div>
                </div>


                <!-- start footer Area -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- End footer Area -->