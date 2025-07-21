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

<main class="content">
  <h1>La tua Wishlist</h1>

  <% if (prodotti == null || prodotti.isEmpty()) { %>
  <p>Non hai prodotti nella wishlist.</p>
  <% } else { %>
  <table>
    <thead>
    <tr>
      <th>Prodotto</th>
      <th>Immagine</th>
      <th>Prezzo</th>
      <th>Aggiungi al carrello</th>
      <th>Rimuovi</th>
    </tr>
    </thead>
    <tbody>
    <% for (Prodotto p : prodotti) { %>
    <tr>
      <td>
        <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>">
          <%= p.getTitolo() %>
        </a>
      </td>
      <td><img id="img-<%= p.getId_prodotto() %>" style="width:100px;"></td>
      <td>€ <%= String.format("%.2f", p.getPrezzo()) %></td>
      <td>
        <form action="aggiungiCarrello" method="post">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button type="submit">Aggiungi al Carrello</button>
        </form>
      </td>
      <td>
        <form action="rimuoviWishlist" method="post">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button type="submit">Rimuovi</button>
        </form>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>
  const immaginiProdotti = {
    1: "<%=baseURL%>/images/prodotto1.jpg",
    2: "<%=baseURL%>/images/prodotto2.jpg",
    3: "<%=baseURL%>/images/prodotto3.jpg"
  };

  <% for (Prodotto p : prodotti) { %>
  const imgTag<%= p.getId_prodotto() %> = document.getElementById("img-<%= p.getId_prodotto() %>");
  if (imgTag<%= p.getId_prodotto() %>) {
    imgTag<%= p.getId_prodotto() %>.src = immaginiProdotti[<%= p.getId_prodotto() %>] || "<%=baseURL%>/images/default.jpg";
  }
  <% } %>
</script>

</body>
</html>