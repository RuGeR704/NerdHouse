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
      object-fit: cover;
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
      <a href="prodotti.jsp?nome=luffy-gear-five">
        <img src="<%= request.getContextPath() %>/images/prodotti/luffyy.png" alt="Luffy">
        <h3>Luffy Gear Five</h3>
      </a>
      <p>Luffy gear 5 statue 30cm statua in resina</p>
      <span class="price">&euro;600</span>
      <div class="tags">
        <span class="tag">GADGET&ACCESSORI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>
      <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
        <i class="fas fa-heart" style="color: red;"></i> Wishlist
      </button>
    </div>

    <!-- Prodotto 2: Attack on Titan -->
    <div class="product">
      <a href="prodotti.jsp?nome=aoT">
        <img src="<%= request.getContextPath() %>/images/prodotti/aoT.jpg" alt="Attack on Titan">
        <h3>Cofanetto Attack on Titan</h3>
      </a>
      <p>Cofanetto con 5 volumi</p>
      <span class="price">&euro;23,50</span>
      <div class="tags">
        <span class="tag">FUMETTI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>
      <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
        <i class="fas fa-heart" style="color: red;"></i> Wishlist
      </button>
    </div>

    <!-- Prodotto 3: Dandadan -->
    <div class="product">
      <a href="prodotti.jsp?nome=dandadan">
        <img src="<%= request.getContextPath() %>/images/prodotti/dandadann.png" alt="Dandadan">
        <h3>Cofanetto Dandadan</h3>
      </a>
      <p>Cofanetto con 5 volumi della serie Dandadan</p>
      <span class="price">&euro;21,87</span>
      <div class="tags">
        <span class="tag">FUMETTI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>
      <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
        <i class="fas fa-heart" style="color: red;"></i> Wishlist
      </button>
    </div>

    <!-- Prodotto 4: Nagatoro -->
    <div class="product">
      <a href="prodotti.jsp?nome=nagatoro">
        <img src="<%= request.getContextPath() %>/images/prodotti/nagatoro_action.png" alt="Nagatoro">
        <h3>Action figure Nagatoro</h3>
      </a>
      <p>Action figure Nagatoro</p>
      <span class="price">&euro;58,87</span>
      <div class="tags">
        <span class="tag">GADGET&ACCESSORI</span>
        <span class="tag">NOVITÀ</span>
      </div>
      <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
        <i class="fas fa-shopping-cart"></i> Aggiungi al carrello
      </button>
      <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
        <i class="fas fa-heart" style="color: red;"></i> Wishlist
      </button>
    </div>

  </div>
</div>

<div class="evidenza">
<h2>Prodotti in evidenza</h2>
</div>

<div class="products-container">

  <!-- Prodotto 4 -->
  <div class="product">
    <a href="prodotti.jsp?nome=call_of_the_night">
      <img src="<%= request.getContextPath() %>/images/prodotti/call_of_night.png" alt="call">
      <h1>Call of the night</h1>
    </a>
    <p>Action figure resina Nazuna 15cm</p>
    <span class="price">&euro;60,00</span>

    <div class="tags">
      <span class="tag">GADGET&ACCESSORI</span>
    </div>

    <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
      <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
    </button>
    <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
      <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
    </button>
  </div>

  <!-- Prodotto 5 -->
  <div class="product">
    <a href="prodotti.jsp?nome=dnagatoricofanetto">
      <img src="<%= request.getContextPath() %>/images/prodotti/cofanettonagatoro.png" alt="nagatoro">
      <h1>Cofanetto Nagatoro</h1>
    </a>
    <p>Cofanetto con 5 volumi della serie Nagatoro</p>
    <span class="price">&euro;29,99</span>

    <div class="tags">
      <span class="tag">FUMETTI</span>
    </div>

    <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
      <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
    </button>
    <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
      <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
    </button>
  </div>


  <!-- Prodotto 7 -->
  <div class="product">
    <a href="prodotti.jsp?nome=naruto-shirt">
      <img src="<%= request.getContextPath() %>/images/prodotti/naruto.png" alt="naruto">
      <h1>Naruto T-Shirt</h1>
    </a>

    <p>T-Shirt Naruto</p>
    <span class="price">&euro;20,00</span>

    <div class="tags">
      <span class="tag">T-SHIRT</span>
    </div>

    <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
      <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
    </button>
    <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
      <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
    </button>
  </div>

  <!-- Prodotto 8 -->
  <div class="product">
    <a href="prodotti.jsp?nome=naruto-poster">
      <img src="<%= request.getContextPath() %>/images/prodotti/posternaruto.png" alt="Naruto">
      <h1>Naruto poster</h1>
    </a>

    <p>Poster Naruto 15x24cm</p>
    <span class="price">&euro;15,00</span>

    <div class="tags">
      <span class="tag">GADGET&ACCESSORI</span>
    </div>

    <button onclick="window.location.href='<%= request.getContextPath() %>/carrello.jsp'">
      <i class="fas fa-shopping-cart" style="margin-right: 6px;"></i> Aggiungi al carrello
    </button>
    <button class="wishlist-btn" onclick="window.location.href='<%= request.getContextPath() %>/wishlist.jsp'">
      <i class="fas fa-heart" style="color: red; margin-right: 6px;"></i> Wishlist
    </button>
  </div>
</div>

<a href="WEB-INF/confermaordine.jsp">Clicca qui per vedere un capolavoro</a>
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
