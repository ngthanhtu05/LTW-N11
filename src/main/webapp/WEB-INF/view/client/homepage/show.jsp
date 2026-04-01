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
          /* ép chiều cao cho 2 slide bằng nhau */
          .single-slide {
            max-height: 400px;
            display: flex;
            align-items: center;

          }

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


        <script>
          $(document).ready(function () {
            $(".active-banner-slider-custom").owlCarousel({
              items: 1,                // 1 slide mỗi lần hiển thị
              loop: true,              // lặp vô tận
              autoplay: true,          // tự động chạy
              autoplayTimeout: 3000,   // đổi slide mỗi 3 giây
              autoplayHoverPause: false, // không dừng khi rê chuột vào
              smartSpeed: 800,         // tốc độ chuyển (ms)
              animateOut: 'animate__slideOutLeft',  // Slide cũ đi sang trái
              animateIn: 'animate__slideInRight',   // Slide mới đi từ phải sang
              dots: true,              // chấm chỉ slide
            });
          });
        </script>

        <body>



          <!-- start banner Area -->
          <section class="banner-area">
            <div class="container">
              <div class="row fullscreen align-items-center justify-content-start">
                <div class="col-lg-12">
                  <div class="active-banner-slider-custom owl-carousel owl-theme owl-loaded">

                    <!-- single-slide 1 -->
                    <div class="row single-slide align-items-center d-flex">
                      <div class="col-lg-8 text-center">
                        <div class="banner-img">
                          <img class="img-fluid" src="/client/img/banner/main.png" alt="">
                        </div>
                      </div>
                      <div class="col-lg-3 col-md-5">
                        <div class="banner-content">
                          <h1>Sport <br>Collection!</h1>
                          <p>Shop bán đồ thể thao</p>
                        </div>
                      </div>
                    </div>

                    <!-- single-slide 2 -->
                    <div class="row single-slide align-items-center d-flex">
                      <div class="col-lg-3 col-md-5">
                        <div class="banner-content">
                          <h1>Sport <br>Collection!</h1>
                          <p>Shop bán đồ thể thao</p>
                        </div>
                      </div>
                      <div class="col-lg-1"></div>
                      <div class="col-lg-8 text-center">
                        <div class="banner-img">
                          <img class="img-fluid" src="/client/img/banner/main2.jpg" alt="">
                        </div>
                      </div>
                    </div>

                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- End banner Area -->

          <!-- start features Area -->
          <section class="features-area section_gap">
            <div class="container">
              <div class="row features-inner">
                <!-- single features -->
                <div class="col-lg-3 col-md-6 col-sm-6">
                  <div class="single-features">
                    <div class="f-icon">
                      <img src="/client/img/features/f-icon1.png" alt="">
                    </div>
                    <h6>Fast Delivery</h6>

                  </div>
                </div>
                <!-- single features -->
                <div class="col-lg-3 col-md-6 col-sm-6">
                  <div class="single-features">
                    <div class="f-icon">
                      <img src="/client/img/features/f-icon2.png" alt="">
                    </div>
                    <h6>Return Policy</h6>

                  </div>
                </div>
                <!-- single features -->
                <div class="col-lg-3 col-md-6 col-sm-6">
                  <div class="single-features">
                    <div class="f-icon">
                      <img src="/client/img/features/f-icon3.png" alt="">
                    </div>
                    <h6>24/7 Support</h6>

                  </div>
                </div>
                <!-- single features -->
                <div class="col-lg-3 col-md-6 col-sm-6">
                  <div class="single-features">
                    <div class="f-icon">
                      <img src="/client/img/features/f-icon4.png" alt="">
                    </div>
                    <h6>Secure Payment</h6>

                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- end features Area -->

          <!-- Start category Area -->
          <section class="category-area">
            <div class="container">
              <div class="row justify-content-center">
                <div class="col-lg-8 col-md-12">
                  <div class="row">
                    <div class="col-lg-8 col-md-8">
                      <div class="single-deal">
                        <div class="overlay"></div>
                        <img class="img-fluid w-100" src="/client/img/category/c1.jpg" alt="">
                        <a href="/client/img/category/c1.jpg" class="img-pop-up" target="_blank">
                          <div class="deal-details">
                            <h6 class="deal-title">Sneaker for Sports</h6>
                          </div>
                        </a>
                      </div>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <div class="single-deal">
                        <div class="overlay"></div>
                        <img class="img-fluid w-100" src="/client/img/category/c2.jpg" alt="">
                        <a href="/client/img/category/c2.jpg" class="img-pop-up" target="_blank">
                          <div class="deal-details">
                            <h6 class="deal-title">Sneaker for Sports</h6>
                          </div>
                        </a>
                      </div>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <div class="single-deal">
                        <div class="overlay"></div>
                        <img class="img-fluid w-100" src="/client/img/category/c3.jpg" alt="">
                        <a href="/client/img/category/c3.jpg" class="img-pop-up" target="_blank">
                          <div class="deal-details">
                            <h6 class="deal-title">Product for Couple</h6>
                          </div>
                        </a>
                      </div>
                    </div>
                    <div class="col-lg-8 col-md-8">
                      <div class="single-deal">
                        <div class="overlay"></div>
                        <img class="img-fluid w-100" src="/client/img/category/c4.jpg" alt="">
                        <a href="/client/img/category/c4.jpg" class="img-pop-up" target="_blank">
                          <div class="deal-details">
                            <h6 class="deal-title">Sneaker for Sports</h6>
                          </div>
                        </a>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-4 col-md-6">
                  <div class="single-deal">
                    <div class="overlay"></div>
                    <img class="img-fluid w-100" src="/client/img/category/c5.jpg" alt="">
                    <a href="/client/img/category/c5.jpg" class="img-pop-up" target="_blank">
                      <div class="deal-details">
                        <h6 class="deal-title">Sneaker for Sports</h6>
                      </div>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </section>
          <!-- End category Area -->

          <!-- start product Area -->
          <section>
            <!-- single product slide -->
            <div class="single-product-slider">
              <div class="container">
                <div class="row justify-content-center">
                  <div class="col-lg-6 text-center">
                    <div class="section-title">
                      <h1>Latest Products</h1>
                      <p>Hiển thị sản phẩm tại đây.</p>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <c:forEach var="product" items="${latestProducts}">

                    <!-- single product -->
                    <div class="col-lg-3 col-md-6">
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
                        <img class="img-fluid" src="/images/product/${product.image}" alt="" style="height: 255px;">
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
                                <form action="/products/add-product-to-cart/${product.id}" method="post"
                                  class="d-inline">
                                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
                      <!-- <div class="single-product">
                    <img class="img-fluid" src="/client/img/product/p1.jpg" alt="">
                    <div class="product-details">
                      <h6>addidas New Hammer sole
                        for Sports person</h6>
                      <div class="price">
                        <h6>$150.00</h6>
                        <h6 class="l-through">$210.00</h6>
                      </div>
                      <div class="prd-bottom">

                        <a href="" class="social-info">
                          <span class="ti-bag"></span>
                          <p class="hover-text">add to bag</p>
                        </a>
                        <a href="" class="social-info">
                          <span class="lnr lnr-heart"></span>
                          <p class="hover-text">Wishlist</p>
                        </a>
                        <a href="" class="social-info">
                          <span class="lnr lnr-sync"></span>
                          <p class="hover-text">compare</p>
                        </a>
                        <a href="" class="social-info">
                          <span class="lnr lnr-move"></span>
                          <p class="hover-text">view more</p>
                        </a>
                      </div>
                    </div>
                  </div> -->
                    </div>
                  </c:forEach>

                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p2.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p3.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">
                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p4.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p5.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p6.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p7.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                  <!-- single product -->
                  <!-- <div class="col-lg-3 col-md-6">
                <div class="single-product">
                  <img class="img-fluid" src="/client/img/product/p8.jpg" alt="">
                  <div class="product-details">
                    <h6>addidas New Hammer sole
                      for Sports person</h6>
                    <div class="price">
                      <h6>$150.00</h6>
                      <h6 class="l-through">$210.00</h6>
                    </div>
                    <div class="prd-bottom">

                      <a href="" class="social-info">
                        <span class="ti-bag"></span>
                        <p class="hover-text">add to bag</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-heart"></span>
                        <p class="hover-text">Wishlist</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-sync"></span>
                        <p class="hover-text">compare</p>
                      </a>
                      <a href="" class="social-info">
                        <span class="lnr lnr-move"></span>
                        <p class="hover-text">view more</p>
                      </a>
                    </div>
                  </div>
                </div>
              </div> -->
                </div>
              </div>
            </div>
            <!-- single product slide -->
            <div class="single-product-slider">
              <!-- Không được xóa div này. Tôi đéo hiểu sao nó lỗi  -->
            </div>
          </section>
          <!-- end product Area -->
          <!-- start footer Area -->
          <jsp:include page="../layout/footer.jsp" />
          <!-- End footer Area -->


        </body>