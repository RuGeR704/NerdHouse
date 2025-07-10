<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 05/07/25
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%
  Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title><%= prodotto.getTitolo() %> | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="product-detail">
  <div class="product-container">
    <h2><%= prodotto.getTitolo() %></h2>
    <p><strong>Autore:</strong> <%= prodotto.getAutore() %></p>
    <p><strong>Lingua:</strong> <%= prodotto.getLingua() %></p>
    <p><strong>Prezzo:</strong> € <%= prodotto.getPrezzo() %></p>
    <p><strong>Data di uscita:</strong> <%= prodotto.getDataUscita() %></p>
    <p><strong>Descrizione:</strong> <%= prodotto.getDescrizione() %></p>
    <p><strong>Editore:</strong> <%= prodotto.getEditore() %></p>
    <p><strong>Disponibilità:</strong> <%= prodotto.isDisponibilità() ? "Disponibile" : "Non disponibile" %></p>

    <form action="aggiungiCarrello" method="post" style="display:inline-block;">
      <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
      <button type="submit"><i class="fas fa-cart-plus"></i> Aggiungi al Carrello</button>
    </form>

    <form action="aggiungiWishlist" method="post" style="display:inline-block;">
      <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
      <button type="submit"><i class="fas fa-star"></i> Aggiungi a Wishlist</button>
    </form>
  </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
