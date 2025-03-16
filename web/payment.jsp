<%-- 
    Document   : payment
    Created on : 12 Mar 2025, 7:21:48 pm
    Author     : Chia Yen
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Payment Method</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            width: 400px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            text-align: left;
        }
        h2 {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .payment-box {
            padding: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .payment-option {
            display: flex;
            justify-content: left;
            align-items: center;
            margin-bottom: 15px;
        }
        .payment-option a {
            display: block;
            padding: 10px;
            transition: transform 0.2s ease-in-out;
        }
        .payment-option a:hover {
            transform: scale(1.1);
        }
        .payment-option img {
            width: 120px; 
            height: auto;
            cursor: pointer;
        }

        .modal {
            display: none;                
            position: fixed;             
            z-index: 999;                
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;             
            background-color: rgba(0,0,0,0.4); 
        }
        .modal-content {
            background-color: #fff;
            margin: 8% auto;            
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
            position: relative;
        }
        .close {
            position: absolute;
            right: 15px;
            top: 15px;
            font-size: 24px;
            cursor: pointer;
        }
        .modal-content h2 {
            margin-top: 0;
            font-size: 20px;
        }
        .modal-content label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        .modal-content input[type="text"],
        .modal-content input[type="number"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .submit-btn {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Select a payment method</h2>
    <div class="payment-box">

        <h2>Credit/Debit Card</h2>
        <div class="payment-option">
            <!-- VISA: Opens Visa Modal -->
            <a href="visaPayment.jsp" onclick="openVisaModal(event)">
                <img src="images/visa_logo.jpg" alt="Visa">
            </a>
            <a href="mastercardPayment.jsp" onclick="openMasterModal(event)">
                <img src="images/mastercard.jpg" alt="MasterCard">
            </a>
        </div>

        <h2>E-wallet</h2>
        <div class="payment-option">
            <a href="gpayPayment.jsp">
                <img src="images/google_pay.jpg" alt="Google Pay">
            </a>
        </div>

    </div>
</div>

<div id="visaModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeVisaModal()">&times;</span>
        <h2>Enter Card Information (Visa)</h2>
        <form action="processVisa.jsp" method="post">
            <label for="visaName">Name on Card:</label>
            <input type="text" id="visaName" name="visaName" required>

            <label for="visaNumber">Card Number (16 digits):</label>
            <input type="text" id="visaNumber" name="visaNumber" maxlength="16" required>

            <label for="visaExpiry">Expiry Date (MM/YY):</label>
            <input type="text" id="visaExpiry" name="visaExpiry" placeholder="MM/YY" required>

            <label for="visaCVV">CVV (Security Code):</label>
            <input type="number" id="visaCVV" name="visaCVV" maxlength="3" required>

            <button type="submit" class="submit-btn">Pay Now</button>
        </form>
    </div>
</div>

<div id="masterModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeMasterModal()">&times;</span>
        <h2>Enter Card Information (MasterCard)</h2>
        <form action="processMasterCard.jsp" method="post">
            <label for="masterName">Name on Card:</label>
            <input type="text" id="masterName" name="masterName" required>

            <label for="masterNumber">Card Number (16 digits):</label>
            <input type="text" id="masterNumber" name="masterNumber" maxlength="16" required>

            <label for="masterExpiry">Expiry Date (MM/YY):</label>
            <input type="text" id="masterExpiry" name="masterExpiry" placeholder="MM/YY" required>

            <label for="masterCVV">CVV (Security Code):</label>
            <input type="number" id="masterCVV" name="masterCVV" maxlength="3" required>

            <button type="submit" class="submit-btn">Pay Now</button>
        </form>
    </div>
</div>

<script>
    // ===== VISA MODAL =====
    function openVisaModal(event) {
        event.preventDefault(); // Stop navigation
        document.getElementById("visaModal").style.display = "block";
    }
    function closeVisaModal() {
        document.getElementById("visaModal").style.display = "none";
    }

    // ===== MASTERCARD MODAL =====
    function openMasterModal(event) {
        event.preventDefault(); // Stop navigation
        document.getElementById("masterModal").style.display = "block";
    }
    function closeMasterModal() {
        document.getElementById("masterModal").style.display = "none";
    }

    // ===== CLICK OUTSIDE TO CLOSE =====
    window.onclick = function(event) {
        let visaModal = document.getElementById("visaModal");
        let masterModal = document.getElementById("masterModal");

        if (event.target === visaModal) {
            visaModal.style.display = "none";
        } else if (event.target === masterModal) {
            masterModal.style.display = "none";
        }
    }
</script>

</body>
</html>

</body>
</html>