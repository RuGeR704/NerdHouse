<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 20/07/25
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%@ page import="Model.CategoriaDAO" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");

  CategoriaDAO categoriaDAO = new CategoriaDAO();

  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>T-Shirt | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<main style="display: flex; margin: 40px;">
  <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
    <h2>Filtro</h2>
    <form action="categoria" method="get">
      <input type="hidden" name="categoria" value="tshirt">

      <label>Tipo:</label>
      <select name="tipo">
        <option value="">Tutti</option>
        <% if (tipi != null) for (String tipo : tipi) { %>
        <option value="<%= tipo %>"><%= tipo %></option>
        <% } %>
      </select><br><br>

      <label>Prezzo (min):</label>
      <input type="number" name="prezzoMin" step="0.01"><br><br>

      <label>Prezzo (max):</label>
      <input type="number" name="prezzoMax" step="0.01"><br><br>

      <label>Disponibilità:</label>
      <select name="disponibilita">
        <option value="">Tutte</option>
        <option value="true">Disponibile</option>
        <option value="false">Non disponibile</option>
      </select><br><br>

      <button type="submit">Filtra</button>
    </form>
  </aside>

  <section style="flex: 1; display: flex; flex-wrap: wrap; gap: 20px;">
    <% if (prodotti != null && !prodotti.isEmpty()) {
      for (Prodotto p : prodotti) { %>
    <div class="product-card" style="border: 1px solid #ccc; padding: 15px; width: 200px;">
      <h3><%= p.getTitolo() %></h3>
      <p><%= p.getDescrizione() %></p>
      <p>€ <%= String.format("%.2f", p.getPrezzo()) %></p>
      <form action="aggiungiCarrello" method="post">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button type="submit">Aggiungi al Carrello</button>
      </form>
    </div>
    <% } } else { %>
    <p>Nessun prodotto trovato.</p>
    <% } %>
  </section>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp"/>

</body>
</html>
