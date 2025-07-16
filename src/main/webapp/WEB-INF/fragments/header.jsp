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
      <a href="<%= request.getContextPath() %>/shop.jsp"><i class="fas fa-store" title="Shop"></i></a>
      <span class="botton-label">Shop</span>
    </div>

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