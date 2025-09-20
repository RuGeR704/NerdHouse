<%@ page import="Model.ImmagineProdotto" %>
<%@ page import="Model.ImmagineProdottoDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>NerdHouse</title>

  <link rel="stylesheet" href="./css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>

    body {
      background-color: #121212;
    }

    .novita-box {
      position: relative;
      z-index: 1;
      overflow: hidden;
      text-align: center;

    }

    .novita-box::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: url("images/sfondo_fumetto.png") no-repeat center;
      background-size: cover;
      opacity: 0.7;
      z-index: -1;
    }


    a {
      color: inherit;
      text-decoration: none;
    }


      h1{
        font-size: 2.2em;
        font-weight: 700;
        color: goldenrod;
        text-decoration-line: underline;
        text-decoration-thickness: 5px;
        text-decoration-color: white ;
        margin-bottom: 20px;
        letter-spacing: 1px;
        text-align: center;
      }


    .novita-box h2 {
      border: 2px solid #ff8300;
      display: inline-block;
      padding: 10px 15px;
      border-radius: 8px;
      background-color: black;
      box-shadow: 0 0 10px rgba(255, 131, 0, 0.5);
      font-size: 2.5em;
      font-weight: bold;
      color: goldenrod;
      text-decoration-line: underline;
      text-decoration-thickness: 5px;
      text-decoration-color: darkred;
      margin: 20px auto; /* ← centrato orizzontalmente */
      text-align: center;
    }

    .evidenza h2 {
      font-size: 2.2em;
      font-weight: 700;
      color: gold;
      text-decoration-line: underline;
      text-decoration-thickness: 5px;
      text-decoration-color: darkred;
      margin-bottom: 20px;
      letter-spacing: 1px;
      text-align: center;
    }


    .banner-container {
      position: relative;
      width: 100%;
      height: 800px;
      overflow: hidden;
    }

    .banner-slider {
      position: relative;
      width: 100%;
      height: 100%;
    }

    .banner-slider img {
      width: 100%;
      height: 100%;
      display: none;
      object-fit: fill;
    }

    .banner-slider img.active {
      display: block;
    }

    .arrow {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      font-size: 60px;
      background: rgba(0,0,0,0.5);
      color: white;
      border: none;
      cursor: pointer;
      padding: 10px;
      z-index: 10;
      border-radius: 50%;
    }

    .arrow.left { left: 10px; }
    .arrow.right { right: 10px; }

    .dots {
      position: absolute;
      bottom: 15px;
      width: 100%;
      display: flex;
      justify-content: center;
      gap: 10px;
    }

    .dot {
      width: 12px;
      height: 12px;
      background: #ddd;
      border-radius: 50%;
      cursor: pointer;
    }

    .dot.active {
      background: #333;
    }

    .products-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      padding: 40px;
    }

    .product {
      width: 250px;
      border: 1px solid #ccc;
      border-radius: 10px;
      padding: 15px;
      text-align: center;
      background: #f9f9f9;
      transition: transform 0.3s ease-in-out;
    }

    .product:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
    }

    .product img {
      width: 100%;
      height: 200px;
      object-fit: contain;
      margin-bottom: 10px;
    }

    .product .price {
      font-weight: bold;
      color: #333;
    }

    .tags {
      margin-top: 10px;
    }

    .tag {
      display: inline-block;
      background-color: #eee;
      color: #555;
      padding: 5px 10px;
      margin: 2px;
      border-radius: 15px;
      font-size: 0.8em;
    }

    .wishlist-btn {
      background-color: transparent;
      border: 1px solid #888;
      padding: 8px 12px;
      border-radius: 8px;
      margin-top: 10px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .wishlist-btn:hover {
      background-color: #f0f0f0;
    }

    .product button {
      display: block;
      width: 100%;
      margin-top: 10px;
      padding: 10px;
      font-size: 0.9em;
      border-radius: 8px;
      border: none;
      cursor: pointer;
      background-color: darkred;
      color: white;
    }

    .product button:hover {
      background-color: #a30000;
    }
  </style>
</head>

<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<div class="banner-container">
  <div class="banner-slider" id="slider">
    <img src="<%= request.getContextPath() %>/images/prodotti/AOT.png" alt="aot" class="slide active">
    <img src="<%= request.getContextPath() %>/images/prodotti/DANDADAN.png" alt="dandadan" class="slide">
    <img src="<%= request.getContextPath() %>/images/prodotti/LUFFy.png" alt="luffy" class="slide">
  </div>

  <button id="prevBtn" class="arrow left" aria-label="immagine precedente" title="Precedente">&#10094;</button>
  <button id="nextBtn" class="arrow right" aria-label="immagine successiva" title="Successiva">&#10095;</button>

  <div class="dots" id="dots"></div>
</div>


<div class="novita-box">
  <h2>NOVITÀ</h2>
  <div class="products-container">

    <!-- Prodotto 1: Luffy -->
    <div class="product">
      <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=30">
        <%
          List<ImmagineProdotto> immaginiOP = new ImmagineProdottoDAO().doRetrieveByProdotto(30);
          if (immaginiOP != null && !immaginiOP.isEmpty()) {
            for (ImmagineProdotto img : immaginiOP) {
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
        <% } } else { %>
        <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
        <% } %>
        <h3>ONE PIECE | LUFFY GEAR FIVE</h3>

      </a>
      <span class="price" style="font-size: 20px; color: darkred;">&euro;600</span>
      <div class="tags">
        <span class="tag">GADGET&ACCESSORI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="aggiungiCarrelloAjax(30)">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="30">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>
    </div>

    <!-- Prodotto 2: Attack on Titan -->
    <div class="product">
      <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=27">
        <%
          List<ImmagineProdotto> immaginiAOT = new ImmagineProdottoDAO().doRetrieveByProdotto(27);
          if (immaginiAOT != null && !immaginiAOT.isEmpty()) {
            for (ImmagineProdotto img : immaginiAOT) {
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
        <% } } else { %>
        <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
        <% } %>
        <h3>ATTACK ON TITAN | COFANETTO NN.16/20</h3>

      </a>
      <span class="price" style="font-size: 20px; color: darkred;">&euro;23,50</span>
      <div class="tags">
        <span class="tag">FUMETTI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="aggiungiCarrelloAjax(27)">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="27">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>
    </div>

    <!-- Prodotto 3: Dandadan -->
    <div class="product">
      <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=29">
        <%
          List<ImmagineProdotto> immaginiDD = new ImmagineProdottoDAO().doRetrieveByProdotto(29);
          if (immaginiDD != null && !immaginiDD.isEmpty()) {
            for (ImmagineProdotto img : immaginiDD) {
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
        <% } } else { %>
        <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
        <% } %>
        <h3>DANDADAN!| COFANETTO DELUXE</h3>

      </a>
      <span class="price" style="font-size: 20px; color: darkred;">&euro;21,87</span>
      <div class="tags">
        <span class="tag">FUMETTI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="aggiungiCarrelloAjax(29)">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="29">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>
    </div>

    <!-- Prodotto 4: Maglietta Marvel -->
    <div class="product">
      <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=35">
        <%
          List<ImmagineProdotto> immaginiMV = new ImmagineProdottoDAO().doRetrieveByProdotto(35);
          if (immaginiMV != null && !immaginiMV.isEmpty()) {
            for (ImmagineProdotto img : immaginiMV) {
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
        <% } } else { %>
        <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
        <% } %>
        <h3>MARVEL COMICS | T-SHIRT</h3>

      </a>
      <span class="price" style="font-size: 20px; color: darkred;">&euro;12,99</span>
      <div class="tags">
        <span class="tag">T-SHIRT</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="aggiungiCarrelloAjax(35)">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>

      <form action="aggiungiWishlist" method="post">
        <input type="hidden" name="idProdotto" value="35">
        <button class="wishlist-btn">
          <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
        </button>
      </form>
    </div>
  </div>
</div>

<div class="evidenza">
<h2>Prodotti in evidenza</h2>
</div>

<div class="products-container">

  <!-- Prodotto 4 -->
  <div class="product">
    <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=39">
      <%
        List<ImmagineProdotto> immaginiFM = new ImmagineProdottoDAO().doRetrieveByProdotto(39);
        if (immaginiFM != null && !immaginiFM.isEmpty()) {
          for (ImmagineProdotto img : immaginiFM) {
      %>
      <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
      <% } } else { %>
      <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
      <% } %>
      <h3>FUNKO! POP | FREDDIE MERCURY</h3>

    </a>
    <span class="price" style="font-size: 20px; color: darkred;">&euro;19,99</span>
    <div class="tags">
      <span class="tag">GADGET&ACCESSORI</span>
    </div>
    <button onclick="aggiungiCarrelloAjax(39)">
      <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
    </button>

    <form action="aggiungiWishlist" method="post">
      <input type="hidden" name="idProdotto" value="39">
      <button class="wishlist-btn">
        <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
      </button>
    </form>
  </div>

  <!-- Prodotto 5 -->
  <div class="product">
    <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=32">
      <%
        List<ImmagineProdotto> immaginiV = new ImmagineProdottoDAO().doRetrieveByProdotto(32);
        if (immaginiV != null && !immaginiV.isEmpty()) {
          for (ImmagineProdotto img : immaginiV) {
      %>
      <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
      <% } } else { %>
      <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
      <% } %>
      <h3>V PER VENDETTA | DC LIBRARY</h3>

    </a>
    <span class="price" style="font-size: 20px; color: darkred;">&euro;36,10</span>
    <div class="tags">
      <span class="tag">FUMETTI</span>
    </div>
    <button onclick="aggiungiCarrelloAjax(32)">
      <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
    </button>

    <form action="aggiungiWishlist" method="post">
      <input type="hidden" name="idProdotto" value="32">
      <button class="wishlist-btn">
        <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
      </button>
    </form>
  </div>


  <!-- Prodotto 7 -->
  <div class="product">
    <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=37">
      <%
        List<ImmagineProdotto> immaginiNR = new ImmagineProdottoDAO().doRetrieveByProdotto(37);
        if (immaginiNR != null && !immaginiNR.isEmpty()) {
          for (ImmagineProdotto img : immaginiNR) {
      %>
      <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
      <% } } else { %>
      <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
      <% } %>
      <h3>NARUTO | T-SHIRT</h3>

    </a>
    <span class="price" style="font-size: 20px; color: darkred;">&euro;15,99</span>
    <div class="tags">
      <span class="tag">T-SHIRT</span>
    </div>
    <button onclick="aggiungiCarrelloAjax(37)">
      <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
    </button>

    <form action="aggiungiWishlist" method="post">
      <input type="hidden" name="idProdotto" value="37">
      <button class="wishlist-btn">
        <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
      </button>
    </form>
  </div>
  <!-- Prodotto 8 -->
  <div class="product">
    <a href="<%= request.getContextPath()%>/dettaglioProdotto?idProdotto=40">
      <%
        List<ImmagineProdotto> immaginiIM = new ImmagineProdottoDAO().doRetrieveByProdotto(40);
        if (immaginiIM != null && !immaginiIM.isEmpty()) {
          for (ImmagineProdotto img : immaginiIM) {
      %>
      <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="width:100%;" /></div>
      <% } } else { %>
      <div><img src="<%= request.getContextPath() %>/images/default.jpg" style="width:100%;" /></div>
      <% } %>
      <h3>MARVEL | CASCO IRONMAN</h3>

    </a>
    <span class="price" style="font-size: 20px; color: darkred;">&euro;139,90</span>
    <div class="tags">
      <span class="tag">GADGET&ACCESSORI</span>
    </div>
    <button onclick="aggiungiCarrelloAjax(40)">
      <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
    </button>

    <form action="aggiungiWishlist" method="post">
      <input type="hidden" name="idProdotto" value="40">
      <button class="wishlist-btn">
        <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
      </button>
    </form>
  </div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>
  const slides = document.querySelectorAll(".slide");
  const dotsContainer = document.getElementById("dots");
  const prevBtn = document.getElementById("prevBtn");
  const nextBtn = document.getElementById("nextBtn");
  let currentIndex = 0;
  let autoplayInterval;

  function showSlide(index) {
    slides.forEach((slide, i) => {
      slide.classList.remove("active");
      slide.style.display = i === index ? "block" : "none";
      dotsContainer.children[i].classList.toggle("active", i === index);
    });
    currentIndex = index;
  }

  function nextSlide() {
    let newIndex = (currentIndex + 1) % slides.length;
    showSlide(newIndex);
  }

  function prevSlide() {
    let newIndex = (currentIndex - 1 + slides.length) % slides.length;
    showSlide(newIndex);
  }

  function startAutoplay() {
    autoplayInterval = setInterval(nextSlide, 4000);
  }

  function stopAutoplay() {
    clearInterval(autoplayInterval);
  }

  slides.forEach((_, i) => {
    const dot = document.createElement("span");
    dot.classList.add("dot");
    if (i === 0) dot.classList.add("active");
    dot.addEventListener("click", () => {
      showSlide(i);
      stopAutoplay();
      startAutoplay();
    });
    dotsContainer.appendChild(dot);
  });

  prevBtn.addEventListener("click", () => {
    prevSlide();
    stopAutoplay();
    startAutoplay();
  });

  nextBtn.addEventListener("click", () => {
    nextSlide();
    stopAutoplay();
    startAutoplay();
  });

  showSlide(0);
  startAutoplay();
</script>
</body>
</html>
