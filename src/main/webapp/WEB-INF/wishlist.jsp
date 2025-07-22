<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%@ page import="Model.ImmagineProdotto" %>
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

<main>

  <% if (prodotti == null || prodotti.isEmpty()) { %>
  <p>Non hai prodotti nella wishlist.</p>
  <% } else { %>
  <ul class="wishlist-list">
    <% for (Prodotto p : prodotti) { %>
    <li class="wishlist-item">
      <div class="wishlist-item-details">
        <%
          List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(p.getId_prodotto());
          if (immagini != null && !immagini.isEmpty()) {
            ImmagineProdotto img = immagini.getFirst();
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="height: 120px; width: auto;" /></div>
        <%
        } else {
        %>
        <div><img src="<%= baseURL %>/images/default.jpg" style="height: 120px; width: auto;"/></div>
        <% } %>
        <div class="wishlist-item-info">
          <strong><%= p.getTitolo() %></strong>
          <p>€<%= String.format("%.2f", p.getPrezzo()) %></p>
        </div>
      </div>

      <div class="wishlist-actions">
          <button onclick="aggiungiCarrelloAjax(<%= p.getId_prodotto() %>)" class="wishlist-btn"><i class="fas fa-cart-plus"></i> Aggiungi al carrello</button>

        <form action="rimuoviWishlist" method="post" style="display:inline;">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button type="submit" class="wishlist-btn remove-btn"><i class="fas fa-trash"></i> Rimuovi</button>
        </form>
      </div>
    </li>
    <% } %>
  </ul>
  <% } %>
</main>

<script>
  var baseURL = '<%= request.getContextPath() %>';

  function aggiungiCarrelloAjax(idProdotto) {
    fetch(baseURL + "/aggiungiCarrello", {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'idProdotto=' + encodeURIComponent(idProdotto)
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                updateCartCount(); // <-- QUI CHIAMALA
              } else {
                alert('Errore durante l\'aggiunta al carrello');
              }
            })
            .catch(() => alert('Errore di rete nell\'aggiungere al carrello'));
  }

  function updateCartCount() {
    fetch(baseURL + "/quantitaCarrello")
            .then(response => response.json())
            .then(data => {
              const cartCountElem = document.getElementById("cart-count");
              if (cartCountElem) {
                cartCountElem.textContent = data.count;
              }
            })
            .catch(() => console.error("Errore nel recupero della quantità del carrello"));
  }
</script>

</body>
</html>
