<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
                                    <h6 class="text-white text-capitalize ps-3">Create User</h6>
                                </div>
                            </div>

                            <div class="card-body px-5 py-4">
                                <div class="row justify-content-center">
                                    <div class="col-md-8">
                                        <!-- Sử dụng enctype="multipart/form-data" để sever biết là đang đẩy lên 1 kiểu dữ liệu là file -->
                                        <form:form method="post" action="/admin/user/create" modelAttribute="newUser"
                                            enctype="multipart/form-data">

                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <c:set var="errorEmail">
                                                        <form:errors path="email" cssClass="invalid-feedback"/>
                                                    </c:set>
                                                    <label class="form-label fw-bold">Email:</label>
                                                    <form:input 
                                                        type="email" 
                                                        class="form-control border ${not empty errorEmail ? 'is-invalid' : ''}"
                                                        style="padding-left: 20px;" path="email" />
                                                    ${errorEmail}
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <c:set var="errorUsername">
                                                        <form:errors path="username" cssClass="invalid-feedback"/>
                                                    </c:set>
                                                    <label class="form-label fw-bold">User name:</label>
                                                    <form:input type="text" class="form-control border ${not empty errorUsername ? 'is-invalid' : ''}"
                                                        style="padding-left: 20px;" path="username" />
                                                    ${errorUsername}
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <c:set var="errorPassword">
                                                        <form:errors path="password" cssClass="invalid-feedback"/>
                                                    </c:set>
                                                    <label class="form-label fw-bold">Password:</label>
                                                    <form:input type="password" class="form-control border ${not empty errorPassword ? 'is-invalid' : ''}"
                                                        style="padding-left: 20px;" path="password" />
                                                    ${errorPassword}
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label fw-bold">Full name:</label>
                                                    <form:input type="text" class="form-control border "
                                                        style="padding-left: 20px;" path="fullName" />
                                                </div>

                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label fw-bold">Phone number:</label>
                                                    <form:input type="text" class="form-control border"
                                                        style="padding-left: 20px;" path="phoneNumber" />
                                                </div>

                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Select role</label>
                                                    <form:select class="form-select border" style="padding-left: 20px;"
                                                        path="role.name">
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


                                                <!-- Upload ảnh -->
                                                <div class="col-md-12 mb-3 ">
                                                    <label class="form-label fw-bold">Avatar:</label>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <label for="formFileLg" class="upload-box">
                                                            <i class="bi bi-cloud-upload"></i>
                                                            <span>Upload image</span>
                                                        </label>

                                                        <input type="file" id="formFileLg" name="images"
                                                            accept="image/*" onchange="previewImage(event)">
                                                        <img id="preview" alt="preview">
                                                    </div>

                                                </div>

                                            </div>
                                            <div class="text-center mt-4">
                                                <button type="submit" class="btn text-white px-4 py-2"
                                                    style="background-color: #ffba00;">
                                                    Create
                                                </button>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </main>

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