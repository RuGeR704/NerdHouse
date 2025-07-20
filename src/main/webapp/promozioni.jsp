<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 20/07/25
  Time: 21:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  List<String> categorie = (List<String>) request.getAttribute("categorie");
  List<String> tipi = (List<String>) request.getAttribute("tipi");
  List<String> editori = (List<String>) request.getAttribute("editori");
  List<String> autori = (List<String>) request.getAttribute("autori");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>Promozioni | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<main style="display: flex; margin: 40px;">
  <!-- Sidebar Filtri -->
  <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
    <h2>Filtra Promozioni</h2>
    <form action="categoria" method="get">
      <input type="hidden" name="categoria" value="promozioni">

      <label>Categoria:</label>
      <select name="categoriaFiltrata">
        <option value="">Tutte</option>
        <% if (categorie != null) for (String cat : categorie) { %>
        <option value="<%= cat %>"><%= cat %></option>
        <% } %>
      </select><br><br>

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

      <label>Lingua:</label>
      <select name="lingua">
        <option value="">Tutte</option>
        <option value="Italiano">Italiano</option>
        <option value="Inglese">Inglese</option>
      </select><br><br>

      <label>Editore:</label>
      <select name="editore">
        <option value="">Tutti</option>
        <% if (editori != null) for (String editore : editori) { %>
        <option value="<%= editore %>"><%= editore %></option>
        <% } %>
      </select><br><br>

      <label>Autore:</label>
      <select name="autore">
        <option value="">Tutti</option>
        <% if (autori != null) for (String autore : autori) { %>
        <option value="<%= autore %>"><%= autore %></option>
        <% } %>
      </select><br><br>

      <button type="submit">Filtra</button>
    </form>
  </aside>

  <!-- Prodotti -->
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
