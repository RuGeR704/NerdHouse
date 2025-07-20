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
      height: 500px;
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
      transition: opacity 5s ease-in-out;
    }

    .banner-slider img.active {
      display: block;
    }

    .arrow {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      font-size: 30px;
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
  </style>
</head>

<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<div class="banner-container">
  <div class="banner-slider" id="slider">
    <img src="<%= request.getContextPath() %>/images/prodotti/AOT.png" alt="aot" class="slide active">
    <img src="<%= request.getContextPath() %>/images/prodotti/DANDADAN.png" alt="dandadan" class="slide">
    <img src="<%= request.getContextPath() %>/images/prodotti/LUFFY.png" alt="luffy" class="slide">
  </div>

  <button id="prevBtn" class="arrow left" aria-label="immagine precedente" title="Precedente">&#10094;</button>
  <button id="nextBtn" class="arrow right" aria-label="immagine successiva" title="Successiva">&#10095;</button>

  <div class="dots" id="dots"></div>
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

  // Init dots
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

