<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>Catalogo | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="catalogo">
  <h1>Catalogo Prodotti</h1>
  <div class="product-grid">
    <% for (Prodotto p : prodotti) { %>
    <div class="product-card">
      <h3>
        <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>">
          <%= p.getTitolo() %>
        </a>
      </h3>
      <p><%= p.getDescrizione() %></p>
      <p>Prezzo: € <%= p.getPrezzo() %></p>
      <form action="aggiungiCarrello" method="post">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit"><i class="fas fa-cart-plus"></i> Aggiungi al Carrello</button>
      </form>
      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit"><i class="fas fa-star"></i> Aggiungi a Wishlist</button>
      </form>
    </div>
    <% } %>
  </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
