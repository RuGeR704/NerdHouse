<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
  String nomeProdotto = request.getParameter("nome");

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

  Map<String, String> callNight = new HashMap<>();
  callNight.put("titolo", "Call of the Night");
  callNight.put("descrizione", "Action figure resina Nazuna 15cm");
  callNight.put("prezzo", "60.00");
  callNight.put("immagine", "call_of_night.png");
  prodotti.put("call_of_the_night", callNight);

  Map<String, String> cofanettoNagatoro = new HashMap<>();
  cofanettoNagatoro.put("titolo", "Cofanetto Nagatoro");
  cofanettoNagatoro.put("descrizione", "Cofanetto con 5 volumi della serie Nagatoro");
  cofanettoNagatoro.put("prezzo", "29.99");
  cofanettoNagatoro.put("immagine", "cofanettonagatoro.png");
  prodotti.put("dnagatoricofanetto", cofanettoNagatoro);

  Map<String, String> actionNagatoro = new HashMap<>();
  actionNagatoro.put("titolo", "Action Figure Nagatoro");
  actionNagatoro.put("descrizione", "Action figure Nagatoro");
  actionNagatoro.put("prezzo", "58.87");
  actionNagatoro.put("immagine", "nagatoro_action.png");
  prodotti.put("nagatoro", actionNagatoro);


  Map<String, String> tshirtNaruto = new HashMap<>();
  tshirtNaruto.put("titolo", "Naruto T-Shirt");
  tshirtNaruto.put("descrizione", "T-Shirt Naruto");
  tshirtNaruto.put("prezzo", "20.00");
  tshirtNaruto.put("immagine", "naruto.png");
  prodotti.put("naruto-shirt", tshirtNaruto);

  Map<String, String> posterNaruto = new HashMap<>();
  posterNaruto.put("titolo", "Poster Naruto");
  posterNaruto.put("descrizione", "Poster Naruto 15x24cm");
  posterNaruto.put("prezzo", "15.00");
  posterNaruto.put("immagine", "posternaruto.png");
  prodotti.put("naruto-poster", posterNaruto);

  Map<String, String> prodotto = prodotti.get(nomeProdotto);
  if (prodotto == null) {
    response.sendRedirect("index.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8" />
  <title><%= prodotto.get("titolo") %> - NerdHouse</title>
  <link rel="stylesheet" href="./css/styles.css" type="text/css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    .product-detail-container {
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px;
    }

    .product-detail {
      max-width: 600px;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 10px;
      background: #fff;
      text-align: center;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    .product-detail img {
      width: 100%;
      max-height: 400px;
      object-fit: contain;
      margin-bottom: 20px;
    }

    .product-detail h2 {
      margin-bottom: 10px;
    }

    .product-detail p {
      font-size: 1.1em;
      margin-bottom: 15px;
    }

    .price {
      font-weight: bold;
      color: darkred;
      font-size: 1.5em;
      margin-bottom: 20px;
    }

    .product-buttons button {
      padding: 10px 20px;
      margin: 10px 5px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1em;
    }

    .btn-shop {
      background-color: darkred;
      color: white;
    }

    .btn-wishlist {
      background-color: white;
      border: 1px solid darkred;
      color: darkred;
    }

    .btn-return {
      background-color: #ddd;
      color: #333;
    }

    .btn-shop:hover {
      background-color: #a30000;
    }

    .btn-wishlist:hover {
      background-color: #f8d7da;
    }

    .btn-return:hover {
      background-color: #ccc;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<div class="product-detail-container">
  <div class="product-detail">
    <img src="<%= request.getContextPath() %>/images/prodotti/<%= prodotto.get("immagine") %>"
         alt="<%= prodotto.get("titolo") %>"/>
    <h2><%= prodotto.get("titolo") %></h2>
    <p><%= prodotto.get("descrizione") %></p>
    <div class="price">&euro; <%= prodotto.get("prezzo") %></div>

    <div class="product-buttons">
      <button class="btn-shop" onclick="window.location.href='carrello.jsp'">
        <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
      </button>
      <button class="btn-wishlist" onclick="window.location.href='wishlist.jsp'">
        <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Aggiungi alla Wishlist
      </button>
      <button class="btn-return" onclick="window.location.href='index.jsp'">
        <i class="fas fa-arrow-left" style="margin-right: 6px;"></i> Torna indietro
      </button>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
