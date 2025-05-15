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
    <title>Registrazione avvenuta con successo!</title>
</head>
<body>

    <h1>Ti sei registrato correttamente!</h1>
    <p>Il tuo nome è ${utente.nome} ${utente.cognome}
    Sei nato il ${utente.dataNascita}. <br>
    La tua mail è ${utente.email} e vivi a ${utente.indirizzo}. <br>
    Numero di telefono: ${utente.telefono}</p>
    <a href="login.jsp">Clicca qui per effettuare il login</a>

</body>
</html>
