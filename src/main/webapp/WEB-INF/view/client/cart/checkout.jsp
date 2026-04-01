<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <fmt:setLocale value="vi_VN" />
                <fmt:setBundle basename="messages" />


                <!-- Start Header Area -->
                <jsp:include page="../layout/header.jsp" />
                <!-- End Header Area -->

                <!-- Start Banner Area -->
                <section class="banner-area organic-breadcrumb">
                    <div class="container">
                        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
                            <div class="col-first">
                                <h1>Checkout</h1>

                            </div>
                        </div>
                    </div>
                </section>
                <!-- End Banner Area -->

                <!--================Checkout Area =================-->
                <section class="checkout_area section_gap">
                    <div class="container">
                        <form:form class="row contact_form" action="/order/create" method="post" modelAttribute="bill">
                            <div class="billing_details">
                                <div class="row">
                                    <div class="col-lg-7">
                                        <h3>Billing Details</h3>

                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                                        <div class="col-md-12 form-group p_star">
                                            <c:set var="errorName">
                                                <form:errors path="name" cssClass="invalid-feedback" />
                                            </c:set>
                                            <form:input path="name"
                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                placeholder="Name" required="required"/>
                                            ${errorName}
                                        </div>

                                        <div class="col-md-12 form-group p_star">
                                            <c:set var="errorPhone">
                                                <form:errors path="phone" cssClass="invalid-feedback" />
                                            </c:set>
                                            <form:input path="phone" type="number"
                                                class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                                                placeholder="Phone number" required="required"/>
                                            ${errorPhone}
                                        </div>

                                        <div class="col-md-12 form-group p_star">
                                            <c:set var="errorEmail">
                                                <form:errors path="email" cssClass="invalid-feedback" />
                                            </c:set>
                                            <form:input path="email"
                                                class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                placeholder="Email Address" required="required"/>
                                            ${errorEmail}
                                        </div>

                                        <div class="col-md-12 form-group p_star">
                                            <c:set var="errorAddress">
                                                <form:errors path="address" cssClass="invalid-feedback" />
                                            </c:set>
                                            <form:textarea
                                                class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                rows="1" path="address" placeholder="Address"
                                                required="required"></form:textarea>
                                            ${errorAddress}
                                        </div>

                                        <div class="col-md-12 form-group">
                                            <div class="creat_account">
                                                <h3>Shipping Details</h3>
                                            </div>
                                            <form:textarea class="form-control" rows="1" path="note"
                                                placeholder="Order Notes"></form:textarea>
                                        </div>


                                    </div>
                                    <div class="col-lg-5">
                                        <div class="order_box">
                                            <h2>Your Order</h2>
                                            <ul class="list">
                                                <li><a href="#">Product <span>Total</span></a></li>
                                                <c:forEach var="item" items="${items}">
                                                    <li><a>${item.product.name} x ${item.quantity}
                                                            <span class="last">
                                                                <fmt:formatNumber
                                                                    value="${item.product.price * item.quantity}"
                                                                    type="currency" />
                                                            </span>
                                                        </a>
                                                    </li>
                                                </c:forEach>


                                                <!--
                                        <li><a href="#">Fresh Tomatoes <span class="middle">x 02</span> <span
                                                    class="last">$720.00</span></a></li>
                                        <li><a href="#">Fresh Brocoli <span class="middle">x 02</span> <span
                                                    class="last">$720.00</span></a></li> -->
                                            </ul>
                                            <div class="voucher_box">
                                                <div class="input-group mb-3">
                                                    <div class="voucher_box mb-4">
                                                        <label class="fw-bold mb-2">Select Voucher:</label>
                                                        <select id="voucherSelect" name="voucherCode"
                                                            class="form-select border" style="padding-left: 20px;">
                                                            <option value="" data-type="none" data-value="0">No voucher
                                                            </option>
                                                            <c:forEach var="voucher" items="${vouchers}">
                                                                <option value="${voucher.code}"
                                                                    data-type="${voucher.discountType}"
                                                                    data-value="${voucher.discountValue}">
                                                                    ${voucher.code}: ${voucher.description}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>


                                                </div>
                                            </div>

                                            <ul class="list list_2">
                                                <li><a>Subtotal <span>
                                                            <fmt:formatNumber value="${totalPrice}" type="currency" />
                                                        </span></a></li>
                                                <li><a>Shipping <span id="shippingAmountSpan">
                                                            <fmt:formatNumber value="${shipPrice}" type="currency" />
                                                        </span></a></li>

                                                <li><a>Discount <span id="discountAmountSpan">
                                                            <fmt:formatNumber value="${Discount}" type="currency" />
                                                        </span></a></li>


                                                <li><a>Total <span id="totalAmountSpan">
                                                            <fmt:formatNumber
                                                                value="${totalPrice - Discount + shipPrice}"
                                                                type="currency" />
                                                        </span></a></li>
                                            </ul>

                                            <div class="payment_item">
                                                <div class="radion_btn">
                                                    <form:radiobutton path="payment" name="payment" id="pay_cash"
                                                        value="CASH" />
                                                    <label for="pay_cash">Cash Payment</label>
                                                    <div class="check"></div>
                                                </div>
                                                <p>Please send a check to Name, Email, Address, Phone
                                                    .</p>
                                            </div>
                                            <div class="payment_item">
                                                <div class="radion_btn">
                                                    <form:radiobutton path="payment" name="payment" id="pay_paypal"
                                                        value="VNPAY" />

                                                    <label for="pay_paypal">Banking payment</label>
                                                    <img src="img/product/card.jpg" alt="">
                                                    <div class="check"></div>
                                                </div>
                                                <p>You can pay with your credit. </p>
                                            </div>

                                            <!-- Buttons -->
                                            <div>
                                                <hr>
                                            </div>

                                            <input type="hidden" name="checkoutToken" value="${checkoutToken}">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" value="${totalPrice - Discount + shipPrice}"
                                                name="totalPrice">

                                            <button type="submit" class="primary-btn" id="btn-cash"
                                                style="display:none;">
                                                Proceed to Cash Payment
                                            </button>

                                            <button type="submit" class="primary-btn" id="btn-paypal"'?'
                                                style="display:none;">
                                                Proceed to PayPal
                                            </button>



                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form:form>
                    </div>
                </section>
                <!--================End Checkout Area =================-->

                <script>
                    const paypalRadio = document.getElementById("pay_paypal");
                    const cashRadio = document.getElementById("pay_cash");
                    const btnPaypal = document.getElementById("btn-paypal");
                    const btnCash = document.getElementById("btn-cash");

                    if (paypalRadio && cashRadio) {
                        paypalRadio.addEventListener("change", function () {
                            btnPaypal.style.display = "inline-block";
                            btnCash.style.display = "none";
                        });

                        cashRadio.addEventListener("change", function () {
                            btnCash.style.display = "inline-block";
                            btnPaypal.style.display = "none";
                        });
                    }


                    const subtotal = ${ totalPrice };
                    const originalShippingCost = ${ shipPrice };

                    const voucherSelect = document.getElementById("voucherSelect");
                    const discountSpan = document.getElementById("discountAmountSpan");
                    const totalSpan = document.getElementById("totalAmountSpan");
                    const shippingSpan = document.getElementById("shippingAmountSpan");
                    const totalPriceInput = document.querySelector('input[name="totalPrice"]');

                    function formatCurrency(value) {
                        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                    }


                    if (voucherSelect) {
                        voucherSelect.addEventListener("change", function () {
                            const selectedOption = voucherSelect.options[voucherSelect.selectedIndex];
                            const discountType = selectedOption.dataset.type;
                            const discountValue = parseFloat(selectedOption.dataset.value);

                            let discountAmount = 0;
                            let currentShippingCost = originalShippingCost;


                            const typeUpperCase = String(discountType).toUpperCase();

                            if (typeUpperCase === "PERCENTAGE") {
                                discountAmount = (subtotal * discountValue) / 100;
                            } else if (typeUpperCase === "FIXED_AMOUNT" || typeUpperCase === "FIXEDAMOUNT") {
                                discountAmount = discountValue;
                            } else if (typeUpperCase === "FREESHIP") {
                                discountAmount = 0;
                                currentShippingCost = 0;
                            }


                            if (discountAmount > subtotal) {
                                discountAmount = subtotal;
                            }


                            const newTotal = subtotal - discountAmount + currentShippingCost;


                            if (discountSpan) discountSpan.textContent = formatCurrency(discountAmount);
                            if (totalSpan) totalSpan.textContent = formatCurrency(newTotal);
                            if (shippingSpan) shippingSpan.textContent = formatCurrency(currentShippingCost);


                            if (totalPriceInput) {
                                totalPriceInput.value = newTotal;
                            }
                        });
                    }
                </script>

                <!-- start footer Area -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- End footer Area -->