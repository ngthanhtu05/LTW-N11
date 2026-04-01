<%@page contentType="text/html" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
							<h1>Confirmation</h1>
				
							</nav>
						</div>
					</div>
				</div>
			</section>
			<!-- End Banner Area -->

			<!--================Order Details Area =================-->
			<section class="order_details section_gap">
				<div class="container">
					<h3 class="title_confirmation">Thank you. Your order has been received.</h3>
					<div class="row order_d_inner">
						<div class="col-lg-4">
							<div class="details_item">
								<h4>Order Info</h4>
								<ul class="list">
									<li><a href="#"><span>Order number</span> : ${information.id}</a></li>
									<li><a href="#"><span>Total</span> :
											<fmt:formatNumber value="${information.totalAmount}" type="currency" />
										</a></li>
									<li><a href="#"><span>Payment method</span> : ${information.paymentMethod}</a></li>
									<li><a href="#"><span>Note</span> : ${information.note}</a></li>
								</ul>
							</div>
						</div>

						<div class="col-lg-6">
							<div class="details_item">
								<h4>Shipping Address</h4>
								<ul class="list">
									<li><a href="#"><span>Name</span> : ${information.name}</a></li>
									<li><a href="#"><span>Email</span> : ${information.email}</a></li>
									<li><a href="#"><span>Phone</span> : ${information.phone}</a></li>
									<li><a href="#"><span>Address </span> : ${information.address}</a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="order_details_table">
						<h2>Order Details</h2>
						<div class="table-responsive">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">Product</th>
										<th scope="col">Quantity</th>
										<th scope="col">Total</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${items}">

										<tr>
											<td>
												<p>${item.product.name}</p>
											</td>
											<td>
												<h5>x ${item.quantity}</h5>
											</td>
											<td>
												<p>
													<fmt:formatNumber value="${item.product.price * item.quantity}"
														type="currency" />
												</p>
											</td>
										</tr>
									</c:forEach>

								
									<tr>
										<td>
											<h4>Subtotal</h4>
										</td>
										<td>
											<h5></h5>
										</td>
										<td>
											<fmt:formatNumber value="${subTotal}" type="currency" />
											<p></p>
										</td>
									</tr>
									<tr>
										<td>
											<h4>Shipping</h4>
										</td>
										<td>
											<h5></h5>
										</td>
										<td>
											<p>
												<fmt:formatNumber value="${shipping}" type="currency" />
											</p>
										</td>
									</tr>
									<tr>
										<td>
											<h4>Discount</h4>
										</td>
										<td>
											<h5></h5>
										</td>
										<td>
											<p>
												<fmt:formatNumber value="${discountAmount}" type="currency" />
											</p>
										</td>
									</tr>
									<tr>
										<td>
											<h4>Total</h4>
										</td>
										<td>
											<h5></h5>
										</td>
										<td>
											<p>
												<fmt:formatNumber value="${totalPrice}" type="currency" />
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section>
			<!--================End Order Details Area =================-->

			<!-- start footer Area -->
			<jsp:include page="../layout/footer.jsp" />

			<!-- End footer Area -->