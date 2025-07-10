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
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />
<main>
  <h1>Grazie per il tuo ordine!</h1>
  <p>Riceverai un'email di conferma a breve.</p>
  <a href="catalogo">Torna al catalogo</a>
</main>
<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>
