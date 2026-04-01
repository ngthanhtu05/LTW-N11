<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%-- Giả định setLocale đã có ở trang layout chính, nhưng vẫn giữ lại cho an toàn --%>
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
                            <div class="row">
                                <div class="col-12">
                                    <div class="card my-4">
                                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                                            <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                                                <h6 class="text-white text-capitalize ps-3">Order Detail
                                                    #${order.id}</h6>
                                            </div>
                                        </div>

                                        <div class="card-body px-4 py-4"> <%-- Tăng padding một chút --%>

                                                <div class="row mb-4">
                                                    <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                                                        <h5 class="mb-3">Order Info</h5>
                                                        <ul class="list-group">
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Order Number:</strong>
                                                                <span class="text-end">#${order.id}</span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Payment Method:</strong>
                                                                <span class="text-dark">${order.paymentMethod}</span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Note:</strong>
                                                                <span class="text-end">${order.note}</span>
                                                            </li>
                                                        </ul>
                                                    </div>

                                                    <div class="col-lg-7 col-md-6">
                                                        <h5 class="mb-3">Shipping Address</h5>
                                                        <ul class="list-group">
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Name:</strong>
                                                                <span class="text-end">${order.name}</span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Email:</strong>
                                                                <span class="text-end">${order.email}</span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Phone:</strong>
                                                                <span class="text-end">${order.phone}</span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Address:</strong>
                                                                <span class="text-end"
                                                                    style="max-width: 70%;">${order.address}</span>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>

                                                <hr class="horizontal dark mt-0 mb-4">

                                                <div class="row">
                                                    <div class="col-12">
                                                        <h5 class="mb-3">Order Items</h5>
                                                        <div class="table-responsive">
                                                            <table class="table table-hover align-items-center mb-0">
                                                                <thead class="table-light">
                                                                    <tr>
                                                                        <th
                                                                            class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                                            Product</th>
                                                                        <th
                                                                            class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                                            Quantity</th>
                                                                        <th
                                                                            class="text-end text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                                            Unit Price</th>
                                                                        <th
                                                                            class="text-end text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                                                                            Total</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="item" items="${orderDetails}">
                                                                        <tr>
                                                                            <td>
                                                                                <p
                                                                                    class="mb-0 text-sm font-weight-bold">
                                                                                    ${item.product.name}</p>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <span
                                                                                    class="text-sm">${item.quantity}</span>
                                                                            </td>
                                                                            <td class="text-end">
                                                                                <span class="text-sm">
                                                                                    <fmt:formatNumber
                                                                                        value="${item.product.price}"
                                                                                        type="currency" />
                                                                                </span>
                                                                            </td>
                                                                            <td class="text-end">
                                                                                <span class="text-sm font-weight-bold">
                                                                                    <fmt:formatNumber
                                                                                        value="${item.product.price * item.quantity}"
                                                                                        type="currency" />
                                                                                </span>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row mt-4 justify-content-end">
                                                    <div class="col-lg-5 col-md-7">
                                                        <h5 class="mb-3">Order Summary</h5>
                                                        <ul class="list-group">
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Subtotal:</strong>
                                                                <span class="text-dark">
                                                                    <fmt:formatNumber value="${order.totalAmount}"
                                                                        type="currency" />
                                                                </span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Shipping:</strong>
                                                                <span class="text-dark">
                                                                    <fmt:formatNumber value="${order.shipPrice}"
                                                                        type="currency" />
                                                                </span>
                                                            </li>
                                                            <li
                                                                class="list-group-item border-0 d-flex justify-content-between ps-0 mb-2">
                                                                <strong class="text-dark">Discount:</strong>
                                                                <span class="text-danger">
                                                                    -
                                                                    <fmt:formatNumber value="${order.discountAmount}"
                                                                        type="currency" />
                                                                </span>
                                                            </li>
                                                            <li
                                                                class="  d-flex justify-content-between ps-0 pt-3 mt-2">
                                                                <strong class="text-dark text-lg">Total:</strong>
                                                                <strong class="text-primary text-lg">
                                                                    <fmt:formatNumber
                                                                        value="${order.totalAmount + order.shipPrice - order.discountAmount}"
                                                                        type="currency" />
                                                                </strong>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>