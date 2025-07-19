<%--
  Created by IntelliJ IDEA.
  User: Rafus
  Date: 14/05/2025
  Time: 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrazione avvenuta con successo! | NerdHouse</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="login-page">
<div class="register-success-dialog">
    <h1>Ti sei registrato correttamente!</h1>
    <p>Benvenuto ${utente.nome} ${utente.cognome}! <br>
    Per entrare nell'area utente, puoi cliccare
    <a href="userServlet">qui</a> </p>
</div>
</main>
<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
