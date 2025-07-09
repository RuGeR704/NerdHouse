<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  double totale = (Double) request.getAttribute("totale");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>Carrello | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main>
  <h2>Il tuo Carrello</h2>

  <% if (prodotti.isEmpty()) { %>
  <p>Il tuo carrello è vuoto.</p>
  <% } else { %>
  <ul class="cart-list">
    <% for (Prodotto p : prodotti) { %>
    <li>
      <strong><%= p.getTitolo() %></strong> - €<%= p.getPrezzo() %>
      <form action="rimuoviDalCarrello" method="post" style="display:inline;">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit"><i class="fas fa-trash"></i></button>
      </form>
    </li>
    <% } %>
  </ul>
  <p><strong>Totale: €<%= totale %></strong></p>
  <% } %>

</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>