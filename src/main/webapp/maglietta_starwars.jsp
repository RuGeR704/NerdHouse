<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>Maglietta Star Wars</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 40px;
      display: flex;
      justify-content: center;
    }

    .product-container {
      background-color: white;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      max-width: 600px;
      text-align: center;
    }

    h1 {
      color: black;
      margin-bottom: 20px;
    }

    img {
      width: 300px;
      border-radius: 10px;
    }

    p {
      font-size: 1.1em;
      margin: 10px 0;
    }

    .price {
      font-size: 1.4em;
      color: #d10000;
    }

    .back-link {
      display: inline-block;
      margin-top: 30px;
      text-decoration: none;
      color: #333;
      font-weight: bold;
      padding: 8px 16px;
      border: 2px solid #333;
      border-radius: 8px;
      transition: background 0.3s;
    }

    .back-link:hover {
      background-color: #333;
      color: white;
    }
  </style>
</head>
<body>

<div class="product-container">
  <h1>Maglietta Star Wars</h1>
  <img src="https://png.pngtree.com/png-vector/20241102/ourmid/pngtree-premium-black-t-shirt-mockup-png-image_14226805.png" alt="T-shirt Star Wars">
  <p class="price">€19.99</p>
  <p>Maglietta ispirata alla saga di Star Wars, in cotone 100% di alta qualità. Disponibile in tutte le taglie.</p>
  <a class="back-link" href="index.jsp">← Torna alla home</a>
</div>

</body>
</html>
