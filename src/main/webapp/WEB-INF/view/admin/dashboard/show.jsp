<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <fmt:setLocale value="vi_VN" />
                <fmt:setBundle basename="messages" />
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                    <link rel="apple-touch-icon" sizes="76x76" href="/admin/img/apple-icon.png">
                    <link rel="icon" type="image/png" href="/admin/img/favicon.png">
                    <title>
                        Dashboard
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
                </head>


                <body class="g-sidenav-show  bg-gray-200">
                    <!-- Sidebar -->
                    <aside
                        class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark"
                        id="sidenav-main">
                        <% request.setAttribute("pageTitle", "Dashboard" ); %>
                            <jsp:include page="../layout/sidebar.jsp" />
                    </aside>
                    <!-- End Sidebar -->
                    <main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
                        <!-- Header -->
                        <!-- End Header -->
                        <div class="container-fluid py-4">
                            <div class="row">
                                <div class="col-xl-6 col-sm-6 mb-xl-4 mb-4">
                                    <div class="card">
                                        <div class="card-header p-3 pt-2">
                                            <div
                                                class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                                                <i class="material-icons opacity-10">group</i>
                                            </div>
                                            <div class="text-end pt-1">
                                                <h5 class="text-sm mb-0 text-capitalize"
                                                    style="color: rgb(19, 19, 19);">User
                                                </h5>
                                                <h4 class="mb-0">${activeUserCount}</h4>
                                            </div>
                                        </div>
                                        <hr class="dark horizontal my-0">
                                        <div class="card-footer p-3"></div>
                                    </div>
                                </div>

                                <div class="col-xl-6 col-sm-6 mb-xl-0 mb-4">
                                    <div class="card">
                                        <div class="card-header p-3 pt-2">
                                            <div
                                                class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
                                                <i class="material-icons opacity-10">inventory_2</i>
                                            </div>
                                            <div class="text-end pt-1">
                                                <h5 class="text-sm mb-0 text-capitalize" style="color: black;">Products
                                                </h5>
                                                <h4 class="mb-0">${productCount}</h4>
                                            </div>
                                        </div>
                                        <hr class="dark horizontal my-0">
                                        <div class="card-footer p-3"></div>
                                    </div>
                                </div>

                                <div class="col-xl-6 col-sm-6 mb-xl-0 mb-4">
                                    <div class="card">
                                        <div class="card-header p-3 pt-2">
                                            <div
                                                class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                                                <i class="material-icons opacity-10">shopping_cart</i>
                                            </div>
                                            <div class="text-end pt-1">
                                                <h5 class="text-sm mb-0 text-capitalize" style="color: black;">Orders
                                                </h5>
                                                <h4 class="mb-0">${orderCount}</h4>
                                            </div>
                                        </div>
                                        <hr class="dark horizontal my-0">
                                        <div class="card-footer p-3"></div>
                                    </div>
                                </div>

                                <div class="col-xl-6 col-sm-6">
                                    <div class="card">
                                        <div class="card-header p-3 pt-2">
                                            <div
                                                class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
                                                <i class="material-icons opacity-10">attach_money</i>
                                            </div>
                                            <div class="text-end pt-1">
                                                <h5 class="text-sm mb-0 text-capitalize" style="color: black;">Sales
                                                </h5>
                                                <h4 class="mb-0">
                                                    <fmt:formatNumber value="${totalSales}" type="currency" />
                                                </h4>


                                            </div>
                                        </div>
                                        <hr class="dark horizontal my-0">
                                        <div class="card-footer p-3"></div>
                                    </div>
                                </div>
                            </div>



                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </main>
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

                </html>