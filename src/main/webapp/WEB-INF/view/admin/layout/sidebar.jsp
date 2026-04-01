<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <link rel="apple-touch-icon" sizes="76x76" href="/admin/img/apple-icon.png">
                <link rel="icon" type="image/png" href="/admin/img/favicon.png">
                <title>
                    Material Dashboard 2 by Creative Tim
                </title>
                <!--     Fonts and icons     -->
                <link rel="stylesheet" type="text/css"
                    href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
                <!-- Nucleo Icons -->
                <link href="/admin/css/nucleo-icons.css" rel="stylesheet" />
                <link href="/admin/css/nucleo-svg.css" rel="stylesheet" />
                <!-- Font Awesome Icons -->
                <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
                <!-- Material Icons -->
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
                <!-- CSS Files -->
                <link id="pagestyle" href="/admin/css/material-dashboard.css" rel="stylesheet" />
                <!-- CSS Bootstrap -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
                    rel="stylesheet" />

                <style>
                    .modal-backdrop.show {
                        opacity: 0.15 !important;
                    }
                </style>

            </head>

            <body>
                <div class="sidenav-header">
                    <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
                        aria-hidden="true" id="iconSidenav"></i>
                    <a class="navbar-brand m-0" href="/admin">
                        <img src="/admin/img/logo-ct.png" class="navbar-brand-img h-100" alt="main_logo">
                        <span class="ms-1 font-weight-bold text-white">Dashboard</span>
                    </a>
                </div>
                <hr class="horizontal light mt-0 mb-2">
                <div class="collapse navbar-collapse  w-auto  max-height-vh-100" id="sidenav-collapse-main">
                    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                            <c:set var="contextPath" value="${pageContext.request.contextPath}" />
                            <c:set var="uri" value="${pageContext.request.requestURI}" />
                            <c:set var="path" value="${fn:substringAfter(uri, contextPath)}" />

                            <!-- <p style="color:white;">DEBUG: ${path}</p> -->

                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link text-white ${path == '/WEB-INF/view/admin/dashboard/show.jsp' ? 'active bg-gradient-primary' : ''}"
                                        href="${contextPath}/admin">

                                        <div
                                            class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                            <i class="material-icons opacity-10">dashboard</i>
                                        </div>
                                        <span class="nav-link-text ms-1">Dashboard</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white ${path == '/WEB-INF/view/admin/order/show.jsp' ? 'active bg-gradient-primary' : ''}"
                                        href="${contextPath}/admin/order">
                                        <div
                                            class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                            <i class="ni ni-single-copy-04"></i>
                                        </div>
                                        <span class="nav-link-text ms-1">Order</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white ${fn:contains(path, '/WEB-INF/view/admin/user/') ? 'active bg-gradient-primary' : ''}"
                                        href="${contextPath}/admin/user">
                                        <div
                                            class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                            <i class="ni ni-circle-08"></i>
                                        </div>
                                        <span class="nav-link-text ms-1">User</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-white ${path == '/WEB-INF/view/admin/product/show.jsp' ? 'active bg-gradient-primary' : ''}"
                                        href="${contextPath}/admin/product">
                                        <div
                                            class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                            <i class="ni ni-box-2"></i>


                                        </div>
                                        <span class="nav-link-text ms-1">Product</span>
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a class="nav-link text-white ${path == '/WEB-INF/view/admin/catalog/show.jsp' ? 'active bg-gradient-primary' : ''}"
                                        href="${contextPath}/admin/catalog">
                                        <div
                                            class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                                            <i class="ni ni-archive-2"></i>


                                        </div>
                                        <span class="nav-link-text ms-1">Catalog</span>
                                    </a>
                                </li>

                            </ul>
                </div>

                <!--   Core JS Files   -->
                <script src="/admin/js/core/popper.min.js"></script>
                <script src="/admin/js/core/bootstrap.min.js"></script>
                <script src="/admin/js/plugins/perfect-scrollbar.min.js"></script>
                <script src="/admin/js/plugins/smooth-scrollbar.min.js"></script>
                <script src="/admin/js/plugins/chartjs.min.js"></script>
                <script>
                    var ctx = document.getElementById("chart-bars").getContext("2d");

                    new Chart(ctx, {
                        type: "bar",
                        data: {
                            labels: ["M", "T", "W", "T", "F", "S", "S"],
                            datasets: [{
                                label: "Sales",
                                tension: 0.4,
                                borderWidth: 0,
                                borderRadius: 4,
                                borderSkipped: false,
                                backgroundColor: "rgba(255, 255, 255, .8)",
                                data: [50, 20, 10, 22, 50, 10, 40],
                                maxBarThickness: 6
                            },],
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false,
                                }
                            },
                            interaction: {
                                intersect: false,
                                mode: 'index',
                            },
                            scales: {
                                y: {
                                    grid: {
                                        drawBorder: false,
                                        display: true,
                                        drawOnChartArea: true,
                                        drawTicks: false,
                                        borderDash: [5, 5],
                                        color: 'rgba(255, 255, 255, .2)'
                                    },
                                    ticks: {
                                        suggestedMin: 0,
                                        suggestedMax: 500,
                                        beginAtZero: true,
                                        padding: 10,
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                        color: "#fff"
                                    },
                                },
                                x: {
                                    grid: {
                                        drawBorder: false,
                                        display: true,
                                        drawOnChartArea: true,
                                        drawTicks: false,
                                        borderDash: [5, 5],
                                        color: 'rgba(255, 255, 255, .2)'
                                    },
                                    ticks: {
                                        display: true,
                                        color: '#f8f9fa',
                                        padding: 10,
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                    }
                                },
                            },
                        },
                    });


                    var ctx2 = document.getElementById("chart-line").getContext("2d");

                    new Chart(ctx2, {
                        type: "line",
                        data: {
                            labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                            datasets: [{
                                label: "Mobile apps",
                                tension: 0,
                                borderWidth: 0,
                                pointRadius: 5,
                                pointBackgroundColor: "rgba(255, 255, 255, .8)",
                                pointBorderColor: "transparent",
                                borderColor: "rgba(255, 255, 255, .8)",
                                borderColor: "rgba(255, 255, 255, .8)",
                                borderWidth: 4,
                                backgroundColor: "transparent",
                                fill: true,
                                data: [50, 40, 300, 320, 500, 350, 200, 230, 500],
                                maxBarThickness: 6

                            }],
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false,
                                }
                            },
                            interaction: {
                                intersect: false,
                                mode: 'index',
                            },
                            scales: {
                                y: {
                                    grid: {
                                        drawBorder: false,
                                        display: true,
                                        drawOnChartArea: true,
                                        drawTicks: false,
                                        borderDash: [5, 5],
                                        color: 'rgba(255, 255, 255, .2)'
                                    },
                                    ticks: {
                                        display: true,
                                        color: '#f8f9fa',
                                        padding: 10,
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                    }
                                },
                                x: {
                                    grid: {
                                        drawBorder: false,
                                        display: false,
                                        drawOnChartArea: false,
                                        drawTicks: false,
                                        borderDash: [5, 5]
                                    },
                                    ticks: {
                                        display: true,
                                        color: '#f8f9fa',
                                        padding: 10,
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                    }
                                },
                            },
                        },
                    });

                    var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");

                    new Chart(ctx3, {
                        type: "line",
                        data: {
                            labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
                            datasets: [{
                                label: "Mobile apps",
                                tension: 0,
                                borderWidth: 0,
                                pointRadius: 5,
                                pointBackgroundColor: "rgba(255, 255, 255, .8)",
                                pointBorderColor: "transparent",
                                borderColor: "rgba(255, 255, 255, .8)",
                                borderWidth: 4,
                                backgroundColor: "transparent",
                                fill: true,
                                data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
                                maxBarThickness: 6

                            }],
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    display: false,
                                }
                            },
                            interaction: {
                                intersect: false,
                                mode: 'index',
                            },
                            scales: {
                                y: {
                                    grid: {
                                        drawBorder: false,
                                        display: true,
                                        drawOnChartArea: true,
                                        drawTicks: false,
                                        borderDash: [5, 5],
                                        color: 'rgba(255, 255, 255, .2)'
                                    },
                                    ticks: {
                                        display: true,
                                        padding: 10,
                                        color: '#f8f9fa',
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                    }
                                },
                                x: {
                                    grid: {
                                        drawBorder: false,
                                        display: false,
                                        drawOnChartArea: false,
                                        drawTicks: false,
                                        borderDash: [5, 5]
                                    },
                                    ticks: {
                                        display: true,
                                        color: '#f8f9fa',
                                        padding: 10,
                                        font: {
                                            size: 14,
                                            weight: 300,
                                            family: "Roboto",
                                            style: 'normal',
                                            lineHeight: 2
                                        },
                                    }
                                },
                            },
                        },
                    });
                </script>
                <script>
                    var win = navigator.platform.indexOf('Win') > -1;
                    if (win && document.querySelector('#sidenav-scrollbar')) {
                        var options = {
                            damping: '0.5'
                        }
                        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
                    }
                </script>
                <!-- Github buttons -->
                <script async defer src="https://buttons.github.io/buttons.js"></script>
                <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
                <script src="/admin/js/material-dashboard.min.js?v=3.0.0"></script>


            </body>