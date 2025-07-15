<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:20
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
  <title>Shop | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main style="display: flex; margin: 40px;">
  <!-- Sidebar Filtri -->
  <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
    <h2 style="color: darkred;">Filtra</h2>
    <form action="catalogoCategoria" method="get">
      <label>Lingua:</label>
      <select name="lingua">
        <option value="">Tutte</option>
        <option value="Italiano">Italiano</option>
        <option value="Inglese">Inglese</option>
      </select>
      <br><br>
      <label>Editore:</label>
      <input type="text" name="editore" placeholder="Inserisci editore">
      <br><br>
      <button type="submit">Applica Filtri</button>
    </form>
  </aside>

  <!-- Prodotti -->
  <section style="flex: 1; display: flex; flex-wrap: wrap; gap: 20px;">
    <% if (prodotti != null && !prodotti.isEmpty()) {
      for (Prodotto p : prodotti) { %>
    <div style="flex: 1 1 200px; border: 2px solid #ddd; border-radius: 10px; padding: 15px; max-width: 250px; background: #fff;">
      <h3 style="color: black;"><%= p.getTitolo() %></h3>
      <p><%= p.getDescrizione() %></p>
      <p style="font-weight: bold; color: red;">Prezzo: € <%= p.getPrezzo() %></p>
      <form action="aggiungiCarrello" method="post">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit">Aggiungi al Carrello</button>
      </form>
      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit">Aggiungi a Wishlist</button>
      </form>
    </div>
    <% }} else { %>
    <p>Nessun prodotto trovato.</p>
    <% } %>
  </section>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>