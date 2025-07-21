<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
  String nomeProdotto = request.getParameter("nome");

  // Simulazione database (puoi sostituirla con DAO)
  Map<String, Map<String, String>> prodotti = new HashMap<>();

  Map<String, String> luffy = new HashMap<>();
  luffy.put("titolo", "Luffy Gear Five");
  luffy.put("descrizione", "Statua in resina 30cm del Gear 5 di Luffy");
  luffy.put("prezzo", "600");
  luffy.put("immagine", "luffyy.png");
  prodotti.put("luffy-gear-five", luffy);

  Map<String, String> aot = new HashMap<>();
  aot.put("titolo", "Cofanetto Attack on Titan");
  aot.put("descrizione", "Cofanetto con 5 volumi di AOT");
  aot.put("prezzo", "23.50");
  aot.put("immagine", "aoT.jpg");
  prodotti.put("aoT", aot);

  Map<String, String> dandadan = new HashMap<>();
  dandadan.put("titolo", "Cofanetto Dandadan");
  dandadan.put("descrizione", "Cofanetto con 5 volumi della serie Dandadan");
  dandadan.put("prezzo", "21.87");
  dandadan.put("immagine", "dandadann.png");
  prodotti.put("dandadan", dandadan);

  Map<String, String> prodotto = prodotti.get(nomeProdotto);
  if (prodotto == null) {
    response.sendRedirect("index.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title><%= prodotto.get("titolo") %> - NerdHouse</title>
  <link rel="stylesheet" href="./css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <style>
    .product-detail-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 50px 20px;
    }

    .product-detail {
      max-width: 800px;
      background: #f5f5f5;
      border-radius: 12px;
      padding: 30px;
      text-align: center;
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .product-detail img {
      max-width: 100%;
      height: auto;
      border-radius: 12px;
      margin-bottom: 20px;
    }

    .product-detail h2 {
      margin-bottom: 10px;
    }

    .product-detail .price {
      font-size: 1.4em;
      font-weight: bold;
      color: #cc0000;
      margin-bottom: 20px;
    }

    .product-detail p {
      margin-bottom: 20px;
    }

    .product-buttons {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .product-buttons button {
      padding: 12px 20px;
      font-size: 1em;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .btn-return {
      background-color: #ddd;
    }

    .btn-return:hover {
      background-color: #bbb;
    }

    .btn-wishlist {
      background-color: #f9f9f9;
      border: 1px solid #aaa;
    }

    .btn-wishlist:hover {
      background-color: #eee;
    }

    .btn-shop {
      background-color: #cc0000;
      color: white;
    }

    .btn-shop:hover {
      background-color: #a30000;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<div class="product-detail-container">
  <div class="product-detail">
    <img src="<%= request.getContextPath() %>/images/prodotti/<%= prodotto.get("immagine") %>" alt="<%= prodotto.get("titolo") %>">
    <h2><%= prodotto.get("titolo") %></h2>
    <p><%= prodotto.get("descrizione") %></p>
    <div class="price">&euro;<%= prodotto.get("prezzo") %></div>

    <div class="product-buttons">
      <button class="btn-return" onclick="window.location.href='index.jsp'">
        ⬅ Torna alla home
      </button>

      <button class="btn-wishlist" onclick="window.location.href='wishlist.jsp'">
        ❤️ Aggiungi alla Wishlist
      </button>

      <button class="btn-shop" onclick="window.location.href='carrello.jsp'">
        🛒 Vai al negozio
      </button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
