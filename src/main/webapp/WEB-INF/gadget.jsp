<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 20/07/25
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%@ page import="Model.ImmagineProdotto" %>
<%@ page import="Model.ImmagineProdottoDAO" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  List<String> tipi = (List<String>) request.getAttribute("tipi");
  List<String> editori = (List<String>) request.getAttribute("editori");
  List<String> autori = (List<String>) request.getAttribute("autori");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>Gadget & Accessori | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<div class="content-shop">

<main style="display: flex; margin: 40px;">
  <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
    <h2>Filtro</h2>
    <form action="categoria" method="get">
      <input type="hidden" name="categoria" value="gadget">

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
    <div class="product-card" style="flex: 1 1 200px; border: 2px solid #ddd; border-radius: 10px; padding: 15px; max-width: 250px; background: #fff;">
      <div class="slider-container">
        <div class="product-images my-slider" id="slider-<%= p.getId_prodotto() %>">
          <%
            List<ImmagineProdotto> immagini = new ImmagineProdottoDAO().doRetrieveByProdotto(p.getId_prodotto());
            if (immagini != null && !immagini.isEmpty()) {
              for (ImmagineProdotto img : immagini) {
          %>
          <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>">
            <div><img class="img-prodotto" src="<%= baseURL + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
          </a>
          <% } } else { %>
          <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>">
            <div><img src="<%= baseURL %>/images/default.jpg" style="width:100%;" /></div>
          </a>
          <% } %>
        </div>
      </div>
      <h3 style="color: black;"><%= p.getTitolo() %></h3>
      <p style="font-weight: bold; color: red; font-size: 26px">€ <%= String.format("%.2f", p.getPrezzo()) %></p>

      <button onclick="aggiungiCarrelloAjax(<%= p.getId_prodotto() %>)">
        <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post" style="margin-top: 10px;">
        <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>
    </div>
    <% }} else { %>
    <p style="color:red; font-weight:bold;">Nessun prodotto trovato con questi filtri.</p>
    <% } %>
  </section>
</main>
</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp"/>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".my-slider").forEach(slider => {
      tns({
        container: slider,
        items: 1,
        slideBy: "page",
        autoplay: true,
        controls: true,
        nav: false,
        autoplayButtonOutput: false,
        controlsText: ['&#10094;', '&#10095;']
      });
    });
  });

</script>

</body>
</html>