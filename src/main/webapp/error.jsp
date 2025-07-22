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
    <title>Errore | NerdHouse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            background-image: url("<%= request.getContextPath()%>/images/errore.jpg");
        }

        h1, p {
            text-align: center;
        }

        /* Container centrale */
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            max-width: 800px;
            margin: 0 auto;
        }

        /* Messaggio di errore */
        .error-message {
            background-color: black;
            margin-top: 100px;
            margin-bottom: 100px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 100%;
        }

        .error-message h1 {
            font-size: 3rem;
            color: #f44336; /* Colore rosso per l'errore */
            margin-bottom: 20px;
        }

        .error-message p {
            font-size: 1.25rem;
            color: white;
            margin-bottom: 30px;
        }

        .button {
            background-color: darkred; /* Verde per il bottone */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: red;
        }

    </style>
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="container">
    <div class="error-message">
        <img src="<%= request.getContextPath()%>/images/error.gif">
        <h1>ERRORE!</h1>
        <p>C'è stato un errore imprevisto. Ci scusiamo per il disagio!</p>
        <a href="<%= request.getContextPath()%>/index.jsp" class="button">Torna alla Home</a>
    </div>
</main>


<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
