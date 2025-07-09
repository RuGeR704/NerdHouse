<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 08/07/25
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.OrdineDettaglio, java.util.List" %>
<%
  List<OrdineDettaglio> ordini = (List<OrdineDettaglio>) request.getAttribute("ordini");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title>I miei ordini | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css" type="text/css">
</head>
<body>
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="ordini-container">
  <h2>I miei ordini</h2>

  <% if (ordini == null || ordini.isEmpty()) { %>
  <p>Non hai ancora effettuato ordini.</p>
  <% } else { %>
  <table class="ordini-table">
    <thead>
    <tr>
      <th>Prodotto</th>
      <th>Data</th>
      <th>Pagamento</th>
      <th>Stato</th>
      <th>Indirizzo</th>
    </tr>
    </thead>
    <tbody>
    <% for (OrdineDettaglio o : ordini) { %>
    <tr>
      <td><%= o.getTitoloProdotto() %> (ID: <%= o.getIdProdotto() %>)</td>
      <td><%= o.getDataOrdine() %></td>
      <td><%= o.getPagamento() %></td>
      <td><%= o.getStato() %></td>
      <td><%= o.getIndirizzoOrdine() %></td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>