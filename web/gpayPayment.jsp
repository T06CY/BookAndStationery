<%-- 
    Document   : gpayPayment
    Created on : 16 Mar 2025, 4:03:27 pm
    Author     : Chia Yen
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Google Pay Payment</title>
    <script src="https://pay.google.com/gp/p/js/pay.js" async defer></script>
</head>
<body>

<h2>Google Pay Checkout</h2>

<div id="gpay_button"></div>

<script>
  const baseRequest = {
    apiVersion: 2,
    apiVersionMinor: 0,
    allowedPaymentMethods: [
      {
        type: "CARD",
        parameters: {
          allowedAuthMethods: ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          allowedCardNetworks: ["MASTERCARD", "VISA"]
        },
        tokenizationSpecification: {
          type: "PAYMENT_GATEWAY",
          parameters: {
            "gateway": "example",
            "gatewayId": "1234567890"
          }
        }
      }
    ],
    merchantInfo: {
      merchantId: "12345678901234567890",
      merchantName: "My Store"
    },
    transactionInfo: {
      totalPriceStatus: "FINAL",
      totalPriceLabel: "Total",
      currencyCode: "MYR",
      countryCode: "MY",
      totalPrice: "25.00"
    }
  };

  const paymentsClient = new google.payments.api.PaymentsClient({
    environment: "TEST"
  });

  const googlePayButton = paymentsClient.createButton({
    onClick: onGooglePaymentButtonClicked
  });
  document.getElementById("gpay_button").appendChild(googlePayButton);

  function onGooglePaymentButtonClicked() {
    paymentsClient.loadPaymentData(baseRequest)
      .then(function(paymentData) {
        console.log("Payment Data:", paymentData);
        alert("Google Pay payment successful!");
      })
      .catch(function(err) {
        console.error("Error loading payment data:", err);
      });
  }
</script>

</body>
</html>