<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <html>

    <head>
        <title>Siêu bảo mật</title>
        <script>
            let timeLeft = 5;

            function countdown() {
                document.getElementById("counter").innerText = timeLeft;
                timeLeft--;

                if (timeLeft < 0) {
                    window.location.href = "https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RDdQw4w9WgXcQ&start_radio=1";
                } else {
                    setTimeout(countdown, 1000);
                }
            }
            window.onload = countdown;
        </script>

        <style>
            body {
                text-align: center;
                padding-top: 100px;
                font-family: Arial;
            }

            #counter {
                font-size: 48px;
                font-weight: bold;
                color: red;
            }
        </style>
    </head>

    <body>
        <h2>Cho 5 giây để rời đi !!!!</h2>
        <span id="counter">5</span> giây
    </body>

    </html>