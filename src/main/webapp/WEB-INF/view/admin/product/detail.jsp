<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:setLocale value="vi_VN" />
                <fmt:setBundle basename="messages" />

                <%-- <link id="pagestyle" href="/admin/css/material-dashboard.css" rel="stylesheet" /> --%>

                <div class="modal fade" id="detailModal${product.id}" tabindex="-1"
                    aria-labelledby="detailModalLabel${product.id}" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg">
                        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">

                            <div class="modal-header bg-gradient-primary text-white">
                                <h5 class="modal-title fw-bold" id="detailModalLabel${product.id}">
                                    <i class="bi bi-box-seam me-2"></i> Product Details
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>

                            <div class="modal-body p-4">
                                <h4 class="text-dark fw-bold mb-4 text-center">${product.name}</h4>

                                <div class="card border-0 shadow-sm rounded-3">
                                    <div class="card-header bg-light p-3 text-center">
                                        <img src="/images/product/${product.image}" alt="Product Image"
                                            class="img-fluid rounded-3 shadow-sm border border-3 p-1"
                                            style="max-height: 200px; object-fit: cover;">
                                        <div class="mt-2 small text-muted">ID: ${product.id}</div>
                                    </div>
                                    <div class="card-body px-4">
                                        <h6 class="fw-semibold mb-3 border-bottom pb-2">
                                            <i class="bi bi-info-circle me-1"></i> General Information
                                        </h6>

                                        <div class="row mb-3">
                                            <div class="col-md-6 mb-2">
                                                <strong><i class="bi bi-list-nested me-1"></i> Category:</strong>
                                                <div class="text-muted">${product.category.name}</div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <strong><i class="bi bi-buildings me-1"></i> Brand:</strong>
                                                <div class="text-muted">${product.brand.name}</div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <div class="col-md-6 mb-2">
                                                <strong><i class="bi bi-currency-dollar me-1"></i> Price:</strong>
                                                <div class="text-muted">
                                                    <fmt:formatNumber value="${product.price}" type="currency" />
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-2">
                                                <strong><i class="bi bi-boxes me-1"></i> Stock Quantity:</strong>
                                                <div class="text-muted">${product.stockQuantity}</div>
                                            </div>
                                        </div>

                                        <h6 class="fw-semibold mb-3 border-bottom pb-2 pt-2">
                                            <i class="bi bi-file-text me-1"></i> Description
                                        </h6>
                                        <p class="text-muted small">${product.description}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="modal-footer border-0">
                                <button type="button" class="btn bg-gradient-primary" data-bs-dismiss="modal">
                                    Close
                                </button>
                            </div>

                        </div>
                    </div>
                </div>