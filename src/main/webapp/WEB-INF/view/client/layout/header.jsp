<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="zxx" class="no-js">

        <head>
            <!-- Mobile Specific Meta -->
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <!-- Favicon-->
            <link rel="shortcut icon" href="/client/img/fav.png">
            <!-- Author Meta -->
            <meta name="author" content="CodePixar">
            <!-- Meta Description -->
            <meta name="description" content="">
            <!-- Meta Keyword -->
            <meta name="keywords" content="">
            <!-- meta character set -->
            <meta charset="UTF-8">
            <!-- Site Title -->
            <title>Sport Shop</title>
            <!--
		CSS
		============================================= -->
            <link rel="stylesheet" href="/client/css/linearicons.css">
            <link rel="stylesheet" href="/client/css/font-awesome.min.css">
            <link rel="stylesheet" href="/client/css/themify-icons.css">
            <link rel="stylesheet" href="/client/css/bootstrap.css">
            <link rel="stylesheet" href="/client/css/owl.carousel.css">
            <link rel="stylesheet" href="/client/css/nice-select.css">
            <link rel="stylesheet" href="/client/css/nouislider.min.css">
            <link rel="stylesheet" href="/client/css/ion.rangeSlider.css" />
            <link rel="stylesheet" href="/client/css/ion.rangeSlider.skinFlat.css" />
            <link rel="stylesheet" href="/client/css/magnific-popup.css">
            <link rel="stylesheet" href="/client/css/main.css">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

            <!--
        Javascript
		============================================= -->
            <script src="/client/js/vendor/jquery-2.2.4.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
                integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
                crossorigin="anonymous"></script>
            <script src="/client/js/vendor/bootstrap.min.js"></script>
            <script src="/client/js/jquery.ajaxchimp.min.js"></script>
            <script src="/client/js/jquery.nice-select.min.js"></script>
            <script src="/client/js/jquery.sticky.js"></script>
            <script src="/client/js/nouislider.min.js"></script>
            <script src="/client/js/jquery.magnific-popup.min.js"></script>
            <script src="/client/js/owl.carousel.min.js"></script>

            <script src="/client/js/main.js"></script>
            <meta name="_csrf" content="${_csrf.token}" />
            <meta name="_csrf_header" content="${_csrf.headerName}" />

        </head>

        <body>
            <header class="header_area">
                <div class="main_menu">
                    <jsp:include page="../layout/navigation.jsp" />
                </div>
            </header>
        </body>