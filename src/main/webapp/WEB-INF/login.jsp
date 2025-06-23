<%--
  Created by IntelliJ IDEA.
  User: Rafus
  Date: 15/05/2025
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login | Nerd House</title>
    <link rel="stylesheet" href="./css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            <a href="AreaUtente.jsp"><i class="fas fa-user user-icon" title="Accedi"></i></a>
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

<main class="login-page">
    <div class="login-container">
        <h2>Accedi</h2>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p class="register-message">
            Non sei ancora registrato? <a href="registrazione.html">Registrati qui!</a>
        </p>
    </div>
</main>

</body>
</html>
