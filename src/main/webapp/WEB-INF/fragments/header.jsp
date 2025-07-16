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

    <div class="botton-item">
      <a href="userServlet"><i class="fas fa-user user-icon" title="Accedi"></i></a>
      <span class="botton-label">Accedi</span>
    </div>

    <div class="botton-item">
      <a href="wishlist"><i class="fas fa-star" title="Wishlist"></i></a>
      <span class="botton-label">Wishlist</span>
    </div>

    <div class="botton-item">
      <a href="carrello"><i class="fas fa-shopping-cart" title="Carrello"></i></a>
      <span class="botton-label">Carrello</span>
    </div>
  </div>
</header>

<nav class="main-navbar">
  <ul class="nav-links">
    <li><a href="#">PROMOZIONI</a></li>
    <li><a href="#">NOVITA'</a></li>
    <li><a href="#">FUMETTI</a></li>
    <li><a href="#">T-SHIRT</a></li>
    <li><a href="#">GADGET & ACCESSORI</a></li>
  </ul>
</nav>