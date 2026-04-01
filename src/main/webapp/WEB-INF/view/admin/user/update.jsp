<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:setLocale value="vi_VN" />
                <fmt:setBundle basename="messages" />
                <link id="pagestyle" href="/admin/css/form-input.css" rel="stylesheet" />

                <aside
                    class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 bg-gradient-dark"
                    id="sidenav-main">
                    <jsp:include page="../layout/sidebar.jsp" />
                </aside>

                <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
                    <div class="container-fluid py-4">
                        <div class="col-12">
                            <div class="card my-4">
                                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                                    <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                                        <h6 class="text-white text-capitalize ps-3">Update User</h6>
                                    </div>
                                </div>

                                <div class="card-body px-5 py-4">
                                    <div class="row justify-content-center">
                                        <div class="col-md-8">
                                            <!-- Sử dụng enctype="multipart/form-data" để sever biết là đang đẩy lên 1 kiểu dữ liệu là file -->
                                            <form:form method="post" action="/admin/user/update"
                                                modelAttribute="newUser" enctype="multipart/form-data">
                                                <!-- Hidden ID -->
                                                <form:input type="hidden" path="id" />

                                                <div class="row">
                                                    <div class="col-md-12 mb-3">
                                                        <c:set var="errorEmail">
                                                            <form:errors path="email" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label class="form-label fw-bold">Email:</label>
                                                        <form:input type="email" class="form-control border bg-light ${not empty errorEmail ? 'is-invalid' : ''}"
                                                            style="padding-left: 20px;" path="email" readonly="true"/>
                                                        ${errorEmail}
                                                    </div>

                                                    <div class="col-md-6 mb-3">
                                                        <c:set var="errorUsername">
                                                            <form:errors path="username" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label class="form-label fw-bold">User name:</label>
                                                        <form:input type="text" class="form-control border bg-light ${not empty errorUsername ? 'is-invalid' : ''}"
                                                            style="padding-left: 20px;" path="username" readonly="true"/>
                                                        ${errorUsername}
                                                    </div>

                                                    <div class="col-md-6 mb-3">
                                                        <label class="form-label fw-bold">Full name:</label>
                                                        <form:input type="text" class="form-control border"
                                                            style="padding-left: 20px;" path="fullName" />
                                                    </div>

                                                    <div class="col-md-6 mb-3">
                                                        <c:set var="errorPhoneNumber">
                                                            <form:errors path="phoneNumber" cssClass="invalid-feedback"/>
                                                        </c:set>
                                                        <label class="form-label fw-bold">Phone number:</label>
                                                        <form:input type="number" 
                                                            class="form-control border ${not empty errorPhoneNumber ? 'is-invalid' : ''}"
                                                            style="padding-left: 20px;" path="phoneNumber" />
                                                        ${errorPhoneNumber}
                                                    </div>

                                                    <div class="col-md-6 mb-3">
                                                        <label class="form-label fw-bold">Select role:</label>
                                                        <form:select class="form-select border"
                                                            style="padding-left: 20px;" path="role.name">
                                                            <form:option value="">-----</form:option>
                                                            <form:option value="ADMIN">ADMIN</form:option>
                                                            <form:option value="USER">USER</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-md-12 mb-3">
                                                        <label class="form-label fw-bold">Address:</label>
                                                        <form:textarea class="form-control border"
                                                            style="padding-left: 20px;" path="address"></form:textarea>
                                                    </div>

                                                    <div class="col-md-6 mb-3" style="display: none;">
                                                        <label class="form-label fw-bold">Image:</label>
                                                        <form:input type="text" class="form-control border"
                                                            style="padding-left: 20px;" path="image" />
                                                    </div>

                                                    <div class="col-md-12 mb-3 ">
                                                        <label class="form-label fw-bold">Avatar:</label>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <label for="formFileLg" class="upload-box">
                                                                <i class="bi bi-cloud-upload"></i>
                                                                <span>Upload image</span>
                                                            </label>

                                                            <!-- Sử dụng name="images" để RequestParam -->
                                                            <input type="file" id="formFileLg" name="images"
                                                                accept="image/*" onchange="previewImage(event)">
                                                            <img id="preview" alt="preview">
                                                        </div>

                                                    </div>

                                                </div>

                                                <div class="text-center mt-4">
                                                    <div class="text-center mt-4">
                                                        <button type="submit" class="btn text-white px-4 py-2"
                                                            style="background-color: #ffba00;">
                                                            Update
                                                        </button>

                                                        <!-- Button Add Voucher -->
                                                        <button type="button" class="btn btn-success px-4 py-2 ms-2"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#addVoucherForUserModal">
                                                            Add Voucher
                                                        </button>
                                                    </div>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </main>
                <!-- Modal Add Voucher to User -->
                <div class="modal fade" id="addVoucherForUserModal" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow-lg">
                            <div class="modal-header bg-gradient-primary text-white">
                                <h5 class="modal-title">Assign Voucher to User</h5>
                                <button type="button" class="btn-close btn-close-white"
                                    data-bs-dismiss="modal"></button>
                            </div>


                            <form action="/admin/user/assign-vouchers" method="post" class="p-3">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="hidden" name="userId" value="${newUser.id}">
                                <div class="row">
                                    <c:forEach var="voucher" items="${vouchers}">
                                        <div class="col-md-4 mb-2">
                                            <div class="form-check">
                                                <input class="form-check-input shadow-sm" type="checkbox"
                                                    name="voucherIds" value="${voucher.id}" id="voucher_${voucher.id}"
                                                    style="width: 2.5rem; height: 1.3rem; cursor: pointer;" <c:if
                                                    test="${mapVouchers[voucher.id] == 1}">checked</c:if> />

                                                <label class="form-check-label d-flex flex-column"
                                                    for="voucher_${voucher.id}" style="color: #000;">
                                                    <span class="fw-bold"
                                                        style="font-size: 15px;">${voucher.code}</span>
                                                    <span class="text-muted" style="font-size: 14px;">
                                                        <c:choose>
                                                            <c:when test="${voucher.discountType == 'percentage'}">
                                                                Giảm ${voucher.discountValue}%
                                                            </c:when>
                                                            <c:otherwise>
                                                                Giảm
                                                                <fmt:formatNumber value="${voucher.discountValue}"
                                                                    type="currency" />
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </label>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn text-white px-4 py-2"
                                        style="background-color: #ffba00;" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn text-white px-4 py-2"
                                        style="background-color: #ffba00;">
                                        Save
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>



                <script>
                    function previewImage(event) {
                        const image = document.getElementById('preview');
                        const uploadBox = document.querySelector('.upload-box');
                        const file = event.target.files[0];

                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                image.src = e.target.result;
                                image.style.display = 'block';

                                // Đợi ảnh load xong để tính chiều cao
                                image.onload = function () {
                                    const newHeight = image.clientHeight;
                                    uploadBox.style.minHeight = newHeight + 'px';
                                };
                            };
                            reader.readAsDataURL(file);
                        }
                    }
                </script>