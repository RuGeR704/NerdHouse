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
    <input type="text" placeholder="Cerca...">
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
        <a href="userServlet" class="dropdown-item">Area Personale</a>
        <a href="logout" class="dropdown-item">Logout</a>
        <% } else { // Utente NON LOGGATO %>
        <a href="userServlet" class="dropdown-item">Accedi</a>
        <a href="registrazione.jsp" class="dropdown-item">Registrati</a>
        <% } %>
      </div>
    </div>

    <div class="botton-item">
      <a href="wishlist"><i class="fas fa-star" title="Wishlist"></i></a>
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
    <li><a href="shop.jsp">PROMOZIONI</a></li>
    <li><a href="#">NOVITA'</a></li>
    <li><a href="#">FUMETTI</a></li>
    <li><a href="#">T-SHIRT</a></li>
    <li><a href="#">GADGET & ACCESSORI</a></li>
  </ul>
</nav>

<script>
  //Script aggiornamento counter carrello
  function updateCartCount() {
    fetch('<%= request.getContextPath() %>/cart/count')
            .then(response => response.json())
            .then(data => {
              const countElement = document.getElementById('cart-count');
              if (countElement) {
                countElement.textContent = data.count;
              }
            })
            .catch(error => {
              console.error("Errore nel recupero del conteggio carrello:", error);
            });
  }

  // Esegui subito all'apertura della pagina
  updateCartCount();

  // script telefono
  document.getElementById('telefono').onclick = function() {
    alert('Il nostro numero: +39 089 456 7890');
  }

</script>
