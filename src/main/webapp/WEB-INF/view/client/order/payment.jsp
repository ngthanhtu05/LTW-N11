<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>QR Payment</title>

    <style>
        body {
            font-family: Arial;
            background: #f5f5f5;
            text-align: center;
        }

        .box {
            background: white;
            padding: 20px;
            margin: 50px auto;
            width: 360px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        img {
            width: 250px;
            margin: 15px 0;
        }

        .status {
            margin-top: 15px;
            font-weight: bold;
            color: orange;
        }
    </style>
</head>

<body>

<div class="box">
    <h2>Thanh toán QR</h2>

    <!-- QR -->
    <img
        src="https://img.vietqr.io/image/<idbank>-<tknganhang>-compact.png?amount=5000&addInfo=${orderCode}&accountName=SPORTSHOP"
    />

    <p>Mã đơn: <b>${orderCode}</b></p>
    <p>Số tiền: <b>${totalAmount} VND</b></p>

    <p id="status" class="status">Đang chờ thanh toán...</p>
</div>

<script>
const orderCode = "${orderCode}";
const amount = 5000;

async function checkPayment() {
    try {
        const res = await fetch("https://oauth.casso.vn/v2/transactions", {
            headers: {
                Authorization: `Apikey apikey`,
                "Content-Type": "application/json",
            },
        });

        const data = await res.json();
        console.log(data)
        const transactions = data?.data?.records || [];
        console.log(transactions)
        const matched = transactions.find(tx => {
            return tx.description?.includes(orderCode)
                && tx.amount >= amount;
        });

        if (matched) {
            document.getElementById("status").innerText = "Thanh toán thành công!";
            document.getElementById("status").style.color = "green";
            setTimeout(() => {
                window.location.href=`/order/payment/check?totalAmount=${totalAmount}&orderCode=${orderCode}`
            }, 4000);
        }

    } catch (err) {
        console.error("Lỗi:", err);
    }
}

// check mỗi 3 giây
setInterval(checkPayment, 15000);
</script>

</body>
</html>