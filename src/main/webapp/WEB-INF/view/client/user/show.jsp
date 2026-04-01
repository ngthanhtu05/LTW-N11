<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <style>
                .theme-gradient-bg {
                    background: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
                }

                .theme-color {
                    color: #ffba00 !important;
                }

                .theme-border-color {
                    border-color: #ffba00 !important;
                }

                .btn-outline-theme {
                    color: #ff6c00;
                    border-color: #ff6c00;
                }

                .btn-outline-theme:hover {
                    background-color: #ff6c00;
                    color: white;
                    border-color: #ff6c00;
                }

                .profile-avatar {
                    width: 150px;
                    height: 150px;
                    object-fit: cover;
                    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
                    border: 4px solid #ffba00;
                }

                .profile-card {
                    margin-top: 100px;
                    margin-bottom: 50px;
                }

                .info-label {
                    font-size: 0.85rem;
                    font-weight: 500;
                    color: #6c757d;
                    margin-bottom: 0.25rem;
                }

                .info-value {
                    font-weight: 600;
                    color: #343a40;
                }
            </style>

            <jsp:include page="../layout/header.jsp" />
            <div class="container profile-card">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card shadow-lg border-0 rounded-3">

                            <div class="card-header theme-gradient-bg text-white p-4 rounded-top-3">
                                <h4 class="mb-0">
                                    <i class="bi bi-person-badge-fill me-2"></i> Hồ sơ cá nhân
                                </h4>
                            </div>

                            <div class="card-body p-4 p-md-5">

                                <div class="text-center mb-5 border-bottom pb-4">
                                    <img src="/images/avatar/${user.image}" alt="${user.fullName}"
                                        class="rounded-circle profile-avatar">
                                    <h3 class="mt-3 fw-bold">${user.fullName}</h3>
                                </div>

                                <div class="row g-4">

                                    <div class="col-md-6">
                                        <p class="info-label">Tên đăng nhập (Username)</p>
                                        <div class="info-value">
                                            <i class="bi bi-person-circle me-2 theme-color"></i> ${user.username}
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <p class="info-label">Họ và Tên</p>
                                        <div class="info-value">
                                            <i class="bi bi-person-vcard-fill me-2 theme-color"></i> ${user.fullName}
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <p class="info-label">Địa chỉ Email</p>
                                        <div class="info-value">
                                            <i class="bi bi-envelope-fill me-2 theme-color"></i> ${user.email}
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <p class="info-label">Số điện thoại</p>
                                        <div class="info-value">
                                            <i class="bi bi-telephone-fill me-2 theme-color"></i> ${user.phoneNumber}
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <p class="info-label">Địa chỉ</p>
                                        <div class="info-value">
                                            <i class="bi bi-geo-alt-fill me-2 theme-color"></i> ${user.address}
                                        </div>
                                    </div>

                                </div>

                                <div class="d-flex justify-content-end mt-5 pt-4 border-top gap-3">
                                    <a href="/profile/update" class="btn fw-semibold text-white theme-gradient-bg">
                                        <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa hồ sơ
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />