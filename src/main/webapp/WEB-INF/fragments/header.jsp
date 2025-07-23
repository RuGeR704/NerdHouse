<%@ page import="Model.Utente" %><%
  // Recupero l'utente dalla sessione per renderlo disponibile nella pagina
  Utente utente = (Utente) session.getAttribute("utente");
%>

<div class="info"> <!-- barra di info -->
  <span id="telefono" style="color:white; cursor:pointer; text-decoration:underline;">Telefono</span>
  <a href="mailto:nerdhouse@email.com" style="color:white; cursor:pointer;">Email</a>
</div>

<header>

  <div class="logo">
    <a href="<%= request.getContextPath() %>/index.jsp"><img src="<%= request.getContextPath() %>/images/logo.PNG" title="logo"></a>
  </div>

  <div class="search-bar">
    <i class="fas fa-search"></i>
    <input type="text" id="search-input" placeholder="Cerca...">
    <div id="searchResults" class="search-results-dropdown"></div>
  </div>

  <div class="header-botton">

    <div class="botton-item dropdown-container">
      <i class="fas fa-user user-icon" title="Profilo"></i>
      <span class="botton-label">
        <%-- Cambia l'etichetta se l'utente è loggato --%>
        <%= (utente != null) ? utente.getNome() : "Accedi" %>
      </span>

      <%-- Questo è il menu a tendina, visibile solo con l'hover --%>
      <div class="dropdown-content">
        <% if (utente != null) { // Utente LOGGATO %>
        <span class="non-clickable">Ciao, <%= utente.getNome() %></span>
        <a href="userServlet?sezione=dati" class="dropdown-item">Area Personale</a>
        <a href="logout" class="dropdown-item">Logout</a>
        <% } else { // Utente NON LOGGATO %>
        <a href="userServlet" class="dropdown-item">Accedi</a>
        <a href="registrazione.jsp" class="dropdown-item">Registrati</a>
        <% } %>
      </div>
    </div>

    <div class="botton-item">
      <a href="userServlet?sezione=wishlist"><i class="fas fa-star" title="Wishlist"></i></a>
      <span class="botton-label">Wishlist</span>
    </div>

    <div class="botton-item cart-button">
      <a href="carrello" class="cart-link">
        <i class="fas fa-shopping-cart" title="Carrello"></i>
        <span class="cart-count" id="cart-count">0</span>
      </a>
      <span class="botton-label">Carrello</span>
    </div>

  </div>
</header>

<nav class="main-navbar">
  <ul class="nav-links">
    <li><a href="categoria">SHOP</a></li>
    <li><a href="promozioni.jsp">PROMOZIONI</a></li>
    <li><a href="novita.jsp">NOVIT&Agrave</a></li>
    <li><a href="fumetti">FUMETTI</a></li>
    <li><a href="tshirt">T-SHIRT</a></li>
    <li><a href="gadget">GADGET & ACCESSORI</a></li>
  </ul>
</nav>

<script>
  //Script aggiornamento counter carrello
  function aggiungiCarrelloAjax(idProdotto) {
    fetch('aggiungiCarrello', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: 'idProdotto=' + encodeURIComponent(idProdotto)
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                aggiornaContatoreCarrello();
              } else {
                alert('Errore durante l\'aggiunta al carrello.');
              }
            });
  }

  function aggiornaContatoreCarrello() {
    fetch('quantitaCarrello')
            .then(response => response.json())
            .then(data => {
              document.getElementById('cart-count').textContent = data.count;
            });
  }

    aggiornaContatoreCarrello();

    // script telefono
    document.getElementById('telefono').onclick = function () {
      alert('Il nostro numero: +39 089 456 7890');
    }

    //Barra di ricerca
    const searchInput = document.getElementById('search-input');
    console.log(searchInput);
    const resultsDropdown = document.getElementById('searchResults');

    const baseURL = window.location.origin + window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1))

    searchInput.addEventListener('input', function () {
      const query = this.value.trim();
      console.log("Query inserita:", query);

      if (query.length < 2) {
        resultsDropdown.style.display = 'none';
        resultsDropdown.innerHTML = '';
        return;
      }

      const searchURL = baseURL + "/searchAjax";

      fetch(searchURL + '?titolo=' + encodeURIComponent(query))
              .then(response => response.json())
              .then(data => {
                if (data.length === 0) {
                  resultsDropdown.style.display = 'none';
                  resultsDropdown.innerHTML = '';
                  return;
                }

                resultsDropdown.innerHTML = '';
                data.forEach(prodotto => {
                  const div = document.createElement('div');
                  const link = document.createElement('a');
                  link.textContent = prodotto.titolo;  // Visualizza il titolo del prodotto

                  // Imposta il link per il dettaglio prodotto
                  link.href = baseURL + `/dettaglioProdotto?idProdotto=` + prodotto.id_prodotto;

                  // Aggiungi un evento per chiudere la lista dei risultati dopo il click
                  link.addEventListener('click', () => {
                    resultsDropdown.style.display = 'none';
                  });

                  // Aggiungi il link al div e poi il div alla lista dei risultati
                  div.appendChild(link);
                  resultsDropdown.appendChild(div);
                });
                resultsDropdown.style.display = 'block';
              })
              .catch(err => {
                console.error('Errore nella ricerca:', err);
              });
    });

</script>