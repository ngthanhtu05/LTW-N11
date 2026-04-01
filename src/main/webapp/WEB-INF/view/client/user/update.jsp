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

                .upload-box {
                    border: 2px dashed #0d6efd;
                    border-radius: 10px;
                    background-color: #f8f9fa;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    flex-direction: column;
                    cursor: pointer;
                    transition: 0.2s;
                    width: 100%;
                    min-height: 150px;
                    height: auto;
                }

                .upload-box:hover {
                    background-color: #e9f2ff;
                    border-color: #007bff;
                }

                .upload-box i {
                    font-size: 28px;
                    color: #0d6efd;
                    margin-bottom: 8px;
                }

                .upload-box span {
                    color: #6c757d;
                    font-size: 14px;
                }

                #formFileLg {
                    display: none;
                }

                #preview {
                    display: none;
                    width: auto;
                    max-width: 200px;
                    max-height: 250px;
                    margin-bottom: 8px;
                    object-fit: contain;
                    border-radius: 10px;
                    border: 1px solid #ddd;
                    transition: 0.3s;
                }

                .form-control:focus,
                .form-select:focus,
                textarea:focus {
                    box-shadow: 0 0 0 0.25rem rgba(0, 0, 0, 0.25) !important;
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

                                <form:form method="post" action="/profile/update" modelAttribute="newUser"
                                    enctype="multipart/form-data">
                                    <!-- Hidden ID -->
                                    <form:input type="hidden" path="id" />
                                    <form:input type="hidden" path="role.name" />


                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <c:set var="errorEmail">
                                                <form:errors path="email" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label fw-bold">Email:</label>
                                            <form:input type="email"
                                                class="form-control border bg-light ${not empty errorEmail ? 'is-invalid' : ''}"
                                                style="padding-left: 20px;" path="email" readonly="true" />
                                            ${errorEmail}
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <c:set var="errorUsername">
                                                <form:errors path="username" cssClass="invalid-feedback" />
                                            </c:set>
                                            <label class="form-label fw-bold">User name:</label>
                                            <form:input type="text"
                                                class="form-control border bg-light ${not empty errorUsername ? 'is-invalid' : ''}"
                                                style="padding-left: 20px;" path="username" readonly="true" />
                                            ${errorUsername}
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label fw-bold">Full name:</label>
                                            <form:input type="text" class="form-control border"
                                                style="padding-left: 20px;" path="fullName" />
                                        </div>

                                        <div class="col-md-12 mb-3">
                                            <c:set var="errorPhoneNumber">
                                                <form:errors path="phoneNumber" cssClass="invalid-feedback"/>
                                            </c:set>
                                            <label class="form-label fw-bold">Phone number:</label>
                                            <form:input type="number" 
                                                class="form-control border ${not empty errorPhoneNumber ? 'is-invalid' : ''}"
                                                style="padding-left: 20px;" path="phoneNumber" />
                                            ${errorPhoneNumber}
                                        </div>


                                        <div class="col-md-12 mb-3">
                                            <label class="form-label fw-bold">Address:</label>
                                            <form:textarea class="form-control border" style="padding-left: 20px;"
                                                path="address"></form:textarea>
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
                                                <input type="file" id="formFileLg" name="images" accept="image/*"
                                                    onchange="previewImage(event)">
                                                <img id="preview" alt="preview">
                                            </div>

                                        </div>

                                    </div>

                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn text-white px-4 py-2"
                                            style="background-color: #ffba00;">
                                            Update
                                        </button>
                                    </div>
                                </form:form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />

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