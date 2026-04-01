<%@page contentType="text/html" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
			<!-- Start Header Area -->
			<jsp:include page="../layout/header.jsp" />
			<!-- End Header Area -->

			<!--================Login Box Area =================-->
			<section class="login_box_area section_gap">
				<div class="container">
					<div class="row">
						<div class="col-lg-6">
							<div class="login_box_img">
								<img class="img-fluid" src="/client/img/login.jpg" alt="">
								<div class="hover">
									<h4>Nếu bạn chưa có tài khoản ?</h4>
									<p>Hãy tạo tài khoản tại đây để được sử dụng những dịch vụ tốt nhất</p>
									<a class="primary-btn" href="/register">Create an Account</a>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="login_form_inner">
								<h3>Log in to enter</h3>
								<c:if test="${param.error != null}">
									<div class="col-md-12 form-group">
										<div>
											<strong>Đăng nhập thất bại!</strong><br>
											Tài khoản hoặc mật khẩu không chính xác.
										</div>
									</div>
								</c:if>
								<form class="row login_form" action="/login" method="post" id="contactForm"
									novalidate="novalidate">
									<div class="col-md-12 form-group">
										<input type="text" class="form-control" name="username" placeholder="Username"
											onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
									</div>

									<div class="col-md-12 form-group">
										<input type="password" class="form-control" name="password"
											placeholder="Password" onfocus="this.placeholder = ''"
											onblur="this.placeholder = 'Password'">
									</div>

									<div>
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									</div>
									<div class="col-md-12 form-group">
										<button type="submit" value="submit" class="primary-btn">Log In</button>

									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!--================End Login Box Area =================-->

			<!-- start footer Area -->
			<jsp:include page="../layout/footer.jsp" />
			<!-- End footer Area -->