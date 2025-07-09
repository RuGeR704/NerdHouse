<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>Wishlist | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main>
  <h2>La tua Wishlist</h2>

  <% if (prodotti.isEmpty()) { %>
  <p>Non hai prodotti nella wishlist.</p>
  <% } else { %>
  <ul class="wishlist-list">
    <% for (Prodotto p : prodotti) { %>
    <li>
      <strong><%= p.getTitolo() %></strong> - €<%= p.getPrezzo() %>
      <form action="aggiungiCarrello" method="post" style="display:inline;">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit"><i class="fas fa-cart-plus"></i></button>
      </form>
      <form action="rimuoviWishlist" method="post" style="display:inline;">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit"><i class="fas fa-trash"></i></button>
      </form>
    </li>
    <% } %>
  </ul>
  <% } %>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>