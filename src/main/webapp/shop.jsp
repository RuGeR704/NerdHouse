<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%@ page import="Model.*" %>

<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  if (prodotti == null) {
    prodotti = (List<Prodotto>) application.getAttribute("prodotti");
  }

  List<Categoria> categorie = (List<Categoria>) request.getAttribute("categorie");
  if (categorie == null) {
    categorie = (List<Categoria>) application.getAttribute("categorie");
  }

  List<String> editori = (List<String>) request.getAttribute("editori");
  List<String> autori = (List<String>) request.getAttribute("autori");

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

  <br>
  <% if (utente != null && utente.isAdmin()) { %>
  <div class="admin-controls" style="margin-bottom: 20px; text-align: right;">
    <button id="aggiungiProdotto" onclick="apriOverlayAggiungi()">Aggiungi prodotto</button>
  </div>
  <% } %>

  <main style="display: flex; margin: 40px;">

    <!-- Sidebar Filtri -->
    <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
      <h2>Filtro</h2>
      <form action="categoria" method="get">
        <label for="categoria">Categoria:</label>
        <select name="categoria" id="categoria">
          <option value="">Tutte</option>
          <% if (categorie != null) {
            for (Categoria c : categorie) { %>
          <option value="<%= c.getIdCategoria() %>"><%= c.getNome() + " - " + c.getTipo() %></option>
          <% }
          } %>
        </select><br><br>

        <label>Prezzo (min):</label>
        <input type="number" name="prezzoMin" step="0.01"><br><br>

        <label>Prezzo (max):</label>
        <input type="number" name="prezzoMax" step="0.01"><br><br>

        <label>Editore:</label>
        <select name="editore">
          <option value="">Tutti</option>
          <%
            String filtroEditore = request.getParameter("editore");
            if (editori != null && !editori.isEmpty()) {
              for (String editore : editori) {
                boolean selected = editore.equals(filtroEditore);
          %>
          <option value="<%= editore %>" <%= selected ? "selected" : "" %>><%= editore %></option>
          <%
              }
            }
          %>
        </select><br><br>

        <label>Autore:</label>
        <select name="autore">
          <option value="">Tutti</option>
          <%
            String filtroAutore = request.getParameter("autore");
            if (autori != null && !autori.isEmpty()) {
              for (String autore : autori) {
                boolean selected = autore.equals(filtroAutore);
          %>
          <option value="<%= autore %>" <%= selected ? "selected" : "" %>><%= autore %></option>
          <%
              }
            }
          %>
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


    <!-- Prodotti -->
    <section style="flex: 1; display: flex; flex-wrap: wrap; gap: 20px;">
      <% if (prodotti != null && !prodotti.isEmpty()) {
        for (Prodotto p : prodotti) {
      %>

      <div class="product-card" data-id="<%= p.getId_prodotto() %>" style="flex: 1 1 200px; border: 2px solid #ddd; border-radius: 10px; padding: 15px; max-width: 250px; background: #fff;">

        <div class="slider-container">
        <div class="product-images my-slider" id="slider-<%= p.getId_prodotto() %>">
          <%
            List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(p.getId_prodotto());
            if (immagini != null && !immagini.isEmpty()) {
              for (ImmagineProdotto img : immagini) {
          %>
          <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>" style="text-decoration: none">
          <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width: 100%;" /></div>  </a>
          <%
            }
          } else {
          %>
          <a href="dettaglioProdotto?idProdotto=<%= p.getId_prodotto() %>" style="text-decoration: none">
          <div><img src="<%= baseURL %>/images/default.jpg" style="width: 100%;" /></div> </a>
          <% } %>
        </div>
        </div>

        <h3 style="color: black;"><%= p.getTitolo() %></h3>


        <p style="font-weight: bold; color: red; font-size: 26px">€ <%= String.format("%.2f", p.getPrezzo()) %></p>

        <button onclick="aggiungiCarrelloAjax(<%= p.getId_prodotto() %>)">
          <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
        </button>

        <form action="aggiungiWishlist" method="post">
          <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
          <button class="wishlist-btn">
            <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
          </button>
        </form>

        <% if (utente != null && utente.isAdmin()) { %>
        <div class="admin-product-actions" style="margin-top: 10px; border-top: 1px solid #eee; padding-top: 10px;">
          <button onclick="apriOverlayModifica(<%= p.getId_prodotto() %>)" style="color: black; background-color: gold;">Modifica</button>
          <form action="rimuoviProdotto" method="post" style="display: inline;" onsubmit="return confirm('Sei sicuro di voler rimuovere questo prodotto?');">
            <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
            <button type="submit" style="background-color: #aa0000; border: none; color: white; cursor: pointer; padding: 0;">Rimuovi</button>
          </form>
        </div>

        <% } %>

      </div>

      <% }} else { %>
      <p style="color:red; font-weight:bold;">Nessun prodotto trovato con questi filtri.</p>
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
        <input type="file" name="immagini[]" multiple accept="image/*" class="file-input">
        <div class="image-preview"></div> <br><br>
        <strong>Titolo:</strong> <input type="text" name="titolo" required><br><br>
        <strong>Descrizione:</strong> <textarea name="descrizione" required></textarea><br><br>

        <strong>Categoria:</strong>
        <select name="categoriaId" required>
          <option value=""> Seleziona categoria</option>
          <%
            if (categorie != null) {
              for (Categoria c : categorie) {
          %>
          <option value="<%= c.getIdCategoria() %>"><%= c.getNome() %> - <%= c.getTipo() %></option>
          <%
              }
            }
          %>
        </select><br><br>

        <strong>Prezzo:</strong> <input type="number" name="prezzo" step="0.01" required><br><br>
        <strong>Autore:</strong> <input type="text" name="autore"><br><br>
        <strong>Data di uscita:</strong> <input type="date" name="dataUscita" required><br><br>
        <strong>Lingua:</strong> <select name="lingua">
          <option value="Italiano">Italiano</option>
          <option value="Inglese">Inglese</option>
          <option value="Giapponese">Giapponese</option>
        </select> <br><br>
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
      <form action="modificaProdotto" method="post" enctype="multipart/form-data">
        <h2>Modifica Prodotto</h2>
        <input type="hidden" name="idProdotto">

        <strong>Immagini attuali:</strong><br>
        <div id="immaginiAttualiContainer" style="display:flex;flex-wrap:wrap;gap:10px;margin-bottom:15px;"></div>
        <input type="hidden" name="immaginiDaRimuovere" id="immaginiDaRimuovere">

        <strong>Aggiungi Immagini:</strong>
        <input type="file" name="nuoveImmagini" multiple accept="image/*" class="file-input">
        <div class="image-preview"></div> <br><br>

        <strong>Titolo:</strong> <input type="text" name="titolo" required><br><br>
        <strong>Descrizione:</strong> <textarea name="descrizione" required></textarea><br><br>

        <strong>Categoria:</strong>
        <select name="categoriaId" required>
          <option value=""> Seleziona categoria</option>
          <%
            if (categorie != null) {
              for (Categoria c : categorie) {
          %>
          <option value="<%= c.getIdCategoria() %>"><%= c.getNome() %> - <%= c.getTipo() %></option>
          <%
              }
            }
          %>
        </select><br><br>

        <strong>Prezzo:</strong> <input type="number" name="prezzo" step="0.01" required><br><br>
        <strong>Autore:</strong> <input type="text" name="autore"><br><br>
        <strong>Data di uscita:</strong> <input type="date" name="dataUscita" required><br><br>
        <strong>Lingua:</strong> <select name="lingua">
        <option value="Italiano">Italiano</option>
        <option value="Inglese">Inglese</option>
        <option value="Giapponese">Giapponese</option>
      </select> <br><br>

        <strong>Editore:</strong> <input type="text" name="editore"><br><br>
        <strong>Disponibilità:</strong>
        <label>
          <input type="radio" name="disponibilita" value="true"> Disponibile
        </label><br>
        <label>
          <input type="radio" name="disponibilita" value="false"> <br> Non Disponibile
        </label> <br><br>
        <button type="submit">Modifica</button>
      </form>
    </div>
  </div>
  <% } %>

</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>

  // Anteprima immagini Modifica e Aggiungi
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.file-input').forEach(input => {
      input.addEventListener("change", function () {
        const previewContainer = input.closest("form").querySelector(".image-preview");
        previewContainer.innerHTML = "";

        Array.from(input.files).forEach(file => {
          if (!file.type.startsWith("image/")) return;

          const reader = new FileReader();
          reader.onload = function (e) {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.style.maxWidth = "100px";
            img.style.maxHeight = "100px";
            img.style.margin = "5px";
            img.style.border = "1px solid #ccc";
            img.style.borderRadius = "4px";
            previewContainer.appendChild(img);
          };
          reader.readAsDataURL(file);
        });
      });
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
    const form = document.getElementById("modificaForm");
    form.style.display = "block";

    const immaginiContainer = document.getElementById("immaginiAttualiContainer");
    immaginiContainer.innerHTML = "";
    const immaginiDaRimuovereInput = document.getElementById("immaginiDaRimuovere");
    immaginiDaRimuovereInput.value = "";

    fetch(baseURL + `/modificaProdotto?id=` + idProdotto)
            .then(response => {
              if (!response.ok) throw new Error("Errore nel recupero del prodotto");
              return response.json();
            })
            .then(data => {
              const prodotto = data.prodotto;
              const immagini = data.immagini || [];

              if (immagini.length === 0) {
                const noImgMsg = document.createElement("p");
                noImgMsg.innerHTML = "Non ci sono immagini";
                noImgMsg.style.fontStyle = "italic";
                noImgMsg.style.color = "#666";
                immaginiContainer.appendChild(noImgMsg);
              }

              const formEl = form.querySelector("form");

              formEl.querySelector("input[name='idProdotto']").value = prodotto.id_prodotto || "";
              formEl.querySelector("input[name='titolo']").value = prodotto.titolo || "";
              formEl.querySelector("textarea[name='descrizione']").value = prodotto.descrizione || "";
              formEl.querySelector("select[name='categoriaId']").value = prodotto.id_categoria || "";
              formEl.querySelector("input[name='prezzo']").value = prodotto.prezzo != null ? prodotto.prezzo : "";
              formEl.querySelector("input[name='autore']").value = prodotto.autore || "";

              // formattazione data a YYYY-MM-DD se necessario
              if (prodotto.dataUscita) {
                const dataUscita = new Date(prodotto.dataUscita);
                const year = dataUscita.getFullYear();
                const month = ("0" + (dataUscita.getMonth() + 1)).slice(-2);
                const day = ("0" + dataUscita.getDate()).slice(-2);
                formEl.querySelector("input[name='dataUscita']").value = year + "-" + month + "-" + day;
              } else {
                formEl.querySelector("input[name='dataUscita']").value = "";
              }

              formEl.querySelector("select[name='lingua']").value = prodotto.lingua || "";
              formEl.querySelector("input[name='editore']").value = prodotto.editore || "";

              if (prodotto.disponibilita === true) {
                formEl.querySelector("input[name='disponibilita'][value='true']").checked = true;
              } else {
                formEl.querySelector("input[name='disponibilita'][value='false']").checked = true;
              }

              immagini.forEach(img => {
                const wrapper = document.createElement("div");
                wrapper.style.position = "relative";
                wrapper.style.display = "inline-block";
                wrapper.style.marginRight = "10px";



                // Assicurati che percorsoImmagine sia URL completo o relativa corretta
                const imageEl = document.createElement("img");
                const baseURL = "<%= baseURL %>";

                imageEl.src = img.percorsoImmagine.startsWith("/")
                        ? baseURL + img.percorsoImmagine
                        : img.percorsoImmagine;

                imageEl.dataset.id = img.idImmagine;

                imageEl.style.width = "100px";
                imageEl.style.height = "auto";
                imageEl.style.borderRadius = "8px";
                imageEl.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.1)";
                imageEl.style.transition = "transform 0.3s ease";
                imageEl.style.objectFit = "cover";

                imageEl.addEventListener("mouseover", () => {
                  imageEl.style.transform = "scale(1.05)";
                });
                imageEl.addEventListener("mouseout", () => {
                  imageEl.style.transform = "scale(1)";
                });

                const removeBtn = document.createElement("button");
                removeBtn.type = "button";
                removeBtn.innerHTML = "✖";
                removeBtn.style.position = "absolute";
                removeBtn.style.top = "-6px";
                removeBtn.style.right = "-6px";
                removeBtn.style.background = "rgba(0, 0, 0, 0.6)";
                removeBtn.style.color = "white";
                removeBtn.style.border = "none";
                removeBtn.style.cursor = "pointer";
                removeBtn.style.borderRadius = "50%";
                removeBtn.style.width = "22px";
                removeBtn.style.height = "22px";
                removeBtn.style.fontSize = "14px";
                removeBtn.style.display = "flex";
                removeBtn.style.alignItems = "center";
                removeBtn.style.justifyContent = "center";
                removeBtn.style.transition = "background 0.2s ease";

                removeBtn.addEventListener("mouseover", () => {
                  removeBtn.style.background = "rgba(255, 0, 0, 0.8)";
                });
                removeBtn.addEventListener("mouseout", () => {
                  removeBtn.style.background = "rgba(0, 0, 0, 0.6)";
                });

                removeBtn.addEventListener("click", () => {
                  wrapper.remove();

                  let currentValue = immaginiDaRimuovereInput.value;
                  const idDaRimuovere = imageEl.dataset.id;
                  // Evita duplicati
                  const ids = currentValue ? currentValue.split(",") : [];
                  if (!ids.includes(String(idDaRimuovere))) {
                    ids.push(idDaRimuovere);
                    immaginiDaRimuovereInput.value = ids.join(",");
                  }
                });

                wrapper.appendChild(imageEl);
                wrapper.appendChild(removeBtn);
                immaginiContainer.appendChild(wrapper);
              });
            })
            .catch(error => {
              alert("Errore nel caricamento del prodotto.");
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
