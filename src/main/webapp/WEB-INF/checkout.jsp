<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 08/07/25
  Time: 12:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<%
  List<Prodotto> prodottiCarrello = (List<Prodotto>) request.getAttribute("prodottiCarrello");
  Float totale = (Float) request.getAttribute("totale");
%>
<html>
<head>
  <title>Checkout | Nerd House</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="checkout">
  <h1>Conferma Ordine</h1>

  <h2>Riepilogo Carrello</h2>
  <ul>
    <% for (Prodotto p : prodottiCarrello) { %>
    <li><strong><%= p.getTitolo() %></strong> - € <%= p.getPrezzo() %></li>
    <% } %>
  </ul>
  <p><strong>Totale: € <%= totale %></strong></p>

  <h2>Dati per la spedizione</h2>
  <form action="checkout" method="post">
    <label for="indirizzo">Indirizzo di spedizione:</label><br>
    <input type="text" name="indirizzo" id="indirizzo" required><br><br>

    <label for="pagamento">Metodo di pagamento:</label><br>
    <select name="pagamento" id="pagamento">
      <option value="Carta di Credito">Carta di Credito</option>
      <option value="PayPal">PayPal</option>
      <option value="Contrassegno">Contrassegno</option>
    </select><br><br>

    <button type="submit">Conferma Ordine</button>
  </form>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>