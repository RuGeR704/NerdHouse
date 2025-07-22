<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 08/07/25
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Ordine Confermato | Nerd House</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

  <style>

    /* Contenitore principale */
    main {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: calc(90vh - 80px);
      padding: 40px 0;
      background-image: url("<%= request.getContextPath()%>/images/sfondo.jpg");
      background-size: cover;
      background-repeat: no-repeat;
      background-position: center;
      background-attachment: fixed;
    }

    .container {
      background-color: #121212;
      padding: 40px 30px;
      border-radius: 10px;
      box-shadow: 0 0 12px rgba(0,0,0,0.1);
      width: 90%;
      max-width: 300px;
      text-align: center;
      display: flex;
      flex-direction: column;
    }

    /* Intestazione */
    h1 {
      font-size: 2.5rem;
      color: #28a745;
      font-weight: bold;
      margin-bottom: 1rem;
    }

    /* Paragrafo del messaggio */
    p {
      font-size: 1.25rem;
      color: #777;
    }

    /* Link del bottone */
    .container a {
      background-color: darkred;
      border-color: gold;
      color: black;
      font-size: 1.2rem;
      border-radius: 5px;
      text-decoration: none;
    }

    .container a:hover {
      background-color: gold;
      border-color: darkred;
    }

  </style>
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />
<main>
  <div class="container">
  <h1>Grazie per il tuo ordine!</h1>
  <p>Riceverai un'email di conferma a breve.</p>
  <a href="<%= request.getContextPath()%>/index.jsp">Torna alla home</a>
  </div>
</main>
<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
