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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="login-page">
    <div class="login-container">
        <h2>Accedi</h2>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>

        <% String errore = (String) request.getAttribute("errore");
            if (errore != null) { %>
        <p style="color: red;"><%= errore %></p>
        <% } %>

        <p class="register-message">
            Non sei ancora registrato? <a href="registrazione.jsp">Registrati qui!</a>
        </p>
    </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

</body>
</html>
