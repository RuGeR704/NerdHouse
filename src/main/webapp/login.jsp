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
    <title>Login</title>
</head>
<body>
<h1>Effettua il login</h1>

    <form action="login">

        <label for="email">Email:</label> <br>
        <input type="email" id="email" name="email"><br><br>
        <label for="password">Password:</label> <br>
        <input type="password" id="password" name="password"> <br><br>
        <input type="submit" value="Entra">

    </form>
</body>
</html>
