<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>NerdHouse</title>

  <link rel="stylesheet" href="./css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>
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

<div class="products-container">
  <!-- Prodotto 1: Luffy -->
  <div class="product">
    <a href="prodotti.jsp?nome=luffy-gear-five">
      <img src="<%= request.getContextPath() %>/images/prodotti/luffyy.png" alt="luffy">
      <h3>Luffy gear five</h3>
    </a>
    <p>Luffy gear 5 statue 30cm statua in resina</p>
    <span class="price">&euro;600</span>

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

  <!-- Prodotto 2: AOT -->
  <div class="product">
    <a href="prodotti.jsp?nome=aoT">
      <img src="<%= request.getContextPath() %>/images/prodotti/aoT.jpg" alt="aot">
      <h3>Cofanetto Attack on Titan</h3>
    </a>
    <p>Cofanetto con 5 volumi</p>
    <span class="price">&euro;23,50</span>

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

  <!-- Prodotto 3: Dandadan -->
  <div class="product">
    <a href="prodotti.jsp?nome=dandadan">
      <img src="<%= request.getContextPath() %>/images/prodotti/dandadann.png" alt="dandadan">
      <h3>Cofanetto Dandadan</h3>
    </a>
    <p>Cofanetto con 5 volumi della serie Dandadan</p>
    <span class="price">&euro;21,87</span>

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
