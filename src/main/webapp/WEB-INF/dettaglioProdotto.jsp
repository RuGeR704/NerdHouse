<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 05/07/25
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="Model.ImmagineProdotto" %>
<%@ page import="java.util.List" %>
<%
  Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title><%= prodotto.getTitolo() %> | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tiny-slider/2.9.4/tiny-slider.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tiny-slider/2.9.4/min/tiny-slider.js"></script>

  <style>
    .slider-container {
      max-width: 600px;
      margin: auto;
    }
    .tns-controls {
      text-align: center;
      margin-top: 10px;
    }
  </style>
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="prodotto-dettaglio">

  <div class="prodotto-container">
    <div class="immagine-prodotto">
      <div class="slider-container">
        <div class="product-images my-slider" id="slider-<%= prodotto.getId_prodotto() %>">
          <%
            List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(prodotto.getId_prodotto());
            if (immagini != null && !immagini.isEmpty()) {
              for (ImmagineProdotto img : immagini) {
          %>
          <div>
            <img
                    class="immagine-prodotto"
                    src="<%= baseURL + img.getPercorsoImmagine() %>"
                    alt="Immagine di <%= prodotto.getTitolo() %>"
                    loading="lazy"
            />
          </div>
          <%
            }
          } else {
          %>
          <div>
            <img
                    src="<%= baseURL %>/images/default.jpg"
                    alt="Immagine di default"
                    loading="lazy"
            />
          </div>
          <%
            }
          %>
        </div>
      </div>
    </div>

    <div class="dettagli-prodotto">
      <h1><%= prodotto.getTitolo() %></h1>
      <p><strong>Descrizione:</strong> <%= prodotto.getDescrizione() %></p>
      <p><strong>Prezzo:</strong></p> <p style="font-size: 48px; font-weight: bolder; color: red;"> € <%= String.format("%.2f", prodotto.getPrezzo()) %></p>
      <p><strong>Lingua:</strong> <%= prodotto.getLingua() %></p>
      <p><strong>Editore:</strong> <%= prodotto.getEditore() %></p>
      <p><strong>Data uscita:</strong> <%= prodotto.getDataUscita() %></p>
      <p><strong>Disponibilità:</strong>
        <% if (prodotto.isDisponibilità()) { %>
        <span style="color:green;">Disponibile</span>
        <% } else { %>
        <span style="color:red;">Non disponibile</span>
        <% } %>
      </p>

      <button onclick="aggiungiCarrelloAjax(<%= prodotto.getId_prodotto() %>)">
        <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>

    </div>
  </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>
  var slider = tns({
    container: '#slider-<%= prodotto.getId_prodotto() %>',
    items: 1,
    slideBy: 'page',
    autoplay: false,
    controls: true,
    nav: true,
    mouseDrag: true,
    gutter: 10,
    speed: 400
  });

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