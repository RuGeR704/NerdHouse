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
      width: 500px;
      height: 200px;
      overflow: hidden;
      margin: 40px auto;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }

    .banner-slider {
      display: flex;
      width: 300%;
      transition: transform 0.5s ease-in-out;
    }

    .banner-slide {
      min-width: 100%;
      height: 100%;
    }

    .banner-slide img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .arrow {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      font-size: 30px;
      background: rgba(0,0,0,0.5);
      color: white;
      border: none;
      padding: 10px;
      cursor: pointer;
      border-radius: 50%;
      z-index: 10;
    }

    .arrow.left {
      left: 10px;
    }

    .arrow.right {
      right: 10px;
    }
  </style>
</head>

<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<div class="banner-container">
  <div class="banner-slider" id="slider">
    <div class="banner-slide"><img src="<%= request.getContextPath() %>/images/prodotti/AOT.png" alt="aot"></div>
    <div class="banner-slide"><img src="<%= request.getContextPath() %>/images/prodotti/DANDADAN.png" alt="dandadan"></div>
    <div class="banner-slide"><img src="<%= request.getContextPath() %>/images/prodotti/LUFFY.png" alt="luffy"></div>
  </div>

  <button id="prevBtn" class="arrow left" aria-label="immagine precedente" title="Precedente">&#10094;</button>
  <button id="nextBtn" class="arrow right" aria-label="immagine successiva" title="Successiva">&#10095;</button>
</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>
  const slider = document.getElementById("slider");
  const slides = document.querySelectorAll(".banner-slide");
  const totalSlides = slides.length;
  let index = 0;

  document.getElementById("nextBtn").addEventListener("click", () => {
    index = (index + 1) % totalSlides;
    slider.style.transform = `translateX(-${index * 100}%)`;
  });

  document.getElementById("prevBtn").addEventListener("click", () => {
    index = (index - 1 + totalSlides) % totalSlides;
    slider.style.transform = `translateX(-${index * 100}%)`;
  });
</script>
</body>
</html>

