<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 21/07/25
  Time: 12:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%@ page import="Model.Prodotto, java.util.List, Model.Utente" %>
<%@ page import="Model.ImmagineProdotto" %>

<%
  List<Prodotto> prodotti = (List<Prodotto>) application.getAttribute("prodotti");
  String baseURL = request.getContextPath();

  Utente utente = (Utente) session.getAttribute("utente");
%>

<html>
<head>
  <title>Shop | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tiny-slider/2.9.4/tiny-slider.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tiny-slider/2.9.4/min/tiny-slider.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<div class="content-shop">

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
        <input type="text" name="editore" id="filter" placeholder="Inserisci editore">
        <br><br>
        <button type="submit">Applica Filtri</button>
      </form>
    </aside>

    <% if (utente != null && utente.isAdmin()) { %>
    <div class="admin-controls" style="margin-bottom: 20px; text-align: right;">
      <button id="aggiungiProdotto" onclick="apriOverlayAggiungi()">Aggiungi prodotto</button>
    </div>
    <% } %>


    <!-- Prodotti -->
    <section style="flex: 1; display: flex; flex-wrap: wrap; gap: 20px;">
      <% if (prodotti != null && !prodotti.isEmpty()) {
        for (Prodotto p : prodotti) {
      %>

      <div class="product-card" data-id="<%= p.getId_prodotto() %>" style="flex: 1 1 200px; border: 2px solid #ddd; border-radius: 10px; padding: 15px; max-width: 250px; background: #fff;">

        <div class="product-images my-slider" id="slider-<%= p.getId_prodotto() %>">
          <%
            List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(p.getId_prodotto());
            if (immagini != null && !immagini.isEmpty()) {
              for (ImmagineProdotto img : immagini) {
          %>
          <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width: 100%;" /></div>
          <%
            }
          } else {
          %>
          <div><img src="<%= baseURL %>/images/default.jpg" style="width: 100%;" /></div>
          <% } %>
        </div>

        <h3 style="color: black;"><%= p.getTitolo() %></h3>

        <p><%= p.getDescrizione() %></p>

        <p style="font-weight: bold; color: red;">Prezzo: € <%= String.format("%.2f", p.getPrezzo()) %></p>

        <form action="aggiungiCarrello" method="post">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button type="submit">Aggiungi al Carrello</button>
        </form>

        <form action="aggiungiWishlist" method="post">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button type="submit">Aggiungi a Wishlist</button>
        </form>

        <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>">Dettagli</a>

        <% if (utente != null && utente.isAdmin()) { %>
        <div class="admin-product-actions" style="margin-top: 10px; border-top: 1px solid #eee; padding-top: 10px;">
          <a href="#" onclick="apriOverlayModifica(<%= p.getId_prodotto() %>)" style="color: blue;">Modifica</a>
          <form action="rimuoviProdotto" method="post" style="display: inline;" onsubmit="return confirm('Sei sicuro di voler rimuovere questo prodotto?');">
            <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
            <button type="submit" style="background: none; border: none; color: red; cursor: pointer; padding: 0;">Rimuovi</button>
          </form>
        </div>

        <% } %>

      </div>
      <% }} else { %>
      <p>Nessun prodotto trovato.</p>
      <% } %>
    </section>
  </main>

  <% if (utente != null && utente.isAdmin()) { %>
  <div id="aggiungiForm" style="display: none;">
    <div id="formContainer">
      <span class="close" onclick="chiudiOverlayAggiungi()">&times;</span>
      <form action="<%= baseURL %>/aggiungiProdotto" method="post" enctype="multipart/form-data">
        <h2>Aggiungi Prodotto</h2>
        <strong>Immagini prodotto:</strong>
        <input type="file" name="immagini[]" multiple accept="image/*"><br><br>
        <strong>Titolo:</strong> <input type="text" name="titolo" required><br><br>
        <strong>Descrizione:</strong> <textarea name="descrizione" required></textarea><br><br>
        <strong>Prezzo:</strong> <input type="number" name="prezzo" step="0.01" required><br><br>
        <strong>Autore:</strong> <input type="text" name="autore"><br><br>
        <strong>Data di uscita:</strong> <input type="date" name="dataUscita" required><br><br>
        <strong>Lingua:</strong> <input type="text" name="lingua"><br><br>
        <strong>Editore:</strong> <input type="text" name="editore"><br><br>
        <button type="submit">Aggiungi</button>
      </form>
    </div>
  </div>
  <% } %>

  <% if (utente != null && utente.isAdmin()) { %>
  <div id="modificaForm" style="display: none;">
    <div id="formContainerModify">
      <span class="close" onclick="chiudiOverlayModifica()">&times;</span>
      <form action="modificaProdotto" method="post">
        <h2>Modifica Prodotto</h2>
        <input type="hidden" name="idProdotto">
        <strong>Titolo:</strong> <input type="text" name="titolo" required><br><br>
        <strong>Descrizione:</strong> <textarea name="descrizione" required></textarea><br><br>
        <strong>Prezzo:</strong> <input type="number" name="prezzo" step="0.01" required><br><br>
        <strong>Autore:</strong> <input type="text" name="autore"><br><br>
        <strong>Data di uscita:</strong> <input type="date" name="dataUscita" required><br><br>
        <strong>Lingua:</strong> <input type="text" name="lingua"><br><br>
        <strong>Editore:</strong> <input type="text" name="editore"><br><br>
        <button type="submit">Modifica</button>
      </form>
    </div>
  </div>
  <% } %>

</div>



<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>

  document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll(".product-card").forEach(card => {
      const id = card.getAttribute("data-id");
      const img = immaginiProdotti[id] || "<%= baseURL %>/images/default.jpg";
      const imgElement = document.createElement("img");
      imgElement.src = img;
      imgElement.alt = "Immagine prodotto";
      imgElement.style.width = "100%";
      card.prepend(imgElement);
    });
  });

  //Funzione per aprire il form "aggiungi prodotto"
  function apriOverlayAggiungi() {
    document.getElementById("aggiungiForm").style.display = "block";
  }

  function chiudiOverlayAggiungi() {
    document.getElementById("aggiungiForm").style.display = "none";
  }


  //Funzione per aprire la modifica prodotto

  const baseURL = "<%= request.getContextPath() %>";

  function apriOverlayModifica(idProdotto) {
    console.log("ID prodotto passato:", idProdotto);
    console.log("URL fetch:", baseURL + `/modificaProdotto?id=` + idProdotto);
    fetch(baseURL + `/modificaProdotto?id=` + idProdotto)
            .then(response => {
              if (!response.ok) throw new Error("Errore server");
              return response.json();
            })
            .then(prodotto => {
              document.querySelector("#modificaForm input[name='idProdotto']").value = prodotto.id_prodotto;
              document.querySelector("#modificaForm input[name='titolo']").value = prodotto.titolo;
              document.querySelector("#modificaForm textarea[name='descrizione']").value = prodotto.descrizione;
              document.querySelector("#modificaForm input[name='prezzo']").value = prodotto.prezzo;
              document.querySelector("#modificaForm input[name='autore']").value = prodotto.autore || "";

              if (prodotto.dataUscita) {
                const rawDate = new Date(prodotto.dataUscita);
                const formattedDate = rawDate.toISOString().split('T')[0];
                document.querySelector("#modificaForm input[name='dataUscita']").value = formattedDate;
              } else {
                document.querySelector("#modificaForm input[name='dataUscita']").value = "";
              }

              document.querySelector("#modificaForm input[name='lingua']").value = prodotto.lingua || "";
              document.querySelector("#modificaForm input[name='editore']").value = prodotto.editore || "";

              document.getElementById("modificaForm").style.display = "block";
            })

            .catch(error => {
              alert("Errore durante il caricamento.");
              console.error(error);
            });
  }

  function chiudiOverlayModifica() {
    document.getElementById("modificaForm").style.display = "none";
  }

  // Chiudi cliccando fuori dal form
  window.addEventListener("click", function(event) {
    const aggiungiOverlay = document.getElementById("aggiungiForm");
    const modificaOverlay = document.getElementById("modificaForm");

    if (event.target === aggiungiOverlay) {
      aggiungiOverlay.style.display = "none";
    }

    if (event.target === modificaOverlay) {
      modificaOverlay.style.display = "none";
    }
  });

  //Slider immagini
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".my-slider").forEach(slider => {
      tns({
        container: slider,
        items: 1,
        slideBy: "page",
        autoplay: true,
        controls: false,
        nav: false,
        autoplayButtonOutput: false
      });
    });
  });

</script>

</body>
</html>
