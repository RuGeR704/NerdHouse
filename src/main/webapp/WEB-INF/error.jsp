<%--
  Created by IntelliJ IDEA.
  User: Rafus
  Date: 14/05/2025
  Time: 10:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error Page</title>
    <link rel="stylesheet" href="./css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<header>
    <div class="logo">
        <a href="index.html"><img src="./images/logo.PNG" title="logo"></a>
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
            <a href="#"><i class="fas fa-star" title="Wishlist"></i></a>
            <span class="botton-label">Wishlist</span>
        </div>

        <div class="botton-item">
            <a href="#"><i class="fas fa-shopping-cart" title="Carrello"></i></a>
            <span class="botton-label">Carrello</span>
        </div>
    </div>
</header>


    <h1>ERRORE!</h1>
    <p>C'è stato un errore imprevisto</p>

</body>
</html>
