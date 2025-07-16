<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 04/07/25
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.ContenutoCarrello, Model.Prodotto" %>
<%@ page import="java.util.List" %>
<%
  List<ContenutoCarrello> carrello = (List<ContenutoCarrello>) request.getAttribute("carrello");
  String baseURL = request.getContextPath();
  float totale = 0;
%>
<html>
<head>
  <title>Carrello | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="content">
  <h1>Il tuo Carrello</h1>

  <% if (carrello == null || carrello.isEmpty()) { %>
  <p>Il tuo carrello è vuoto.</p>
  <% } else { %>
  <table>
    <thead>
    <tr>
      <th>Prodotto</th>
      <th>Immagine</th>
      <th>Prezzo unitario</th>
      <th>Quantità</th>
      <th>Totale</th>
      <th>Rimuovi</th>
    </tr>
    </thead>
    <tbody>
    <% for (ContenutoCarrello item : carrello) {
      Prodotto prodotto = item.getProdotto();
      double prezzo = prodotto.getPrezzo();
      int quantita = item.getQuantita();
      double subtotale = prezzo * quantita;
      totale += subtotale;
    %>
    <tr>
      <td>
        <a href="dettaglioProdotto?idProdotto=<%= prodotto.getId_prodotto() %>">
          <%= prodotto.getTitolo() %>
        </a>
      </td>
      <td>
        <img src="<%= prodotto.getImmagine() %>" alt="Immagine prodotto" style="width:100px;">
      </td>
      <td>€ <%= String.format("%.2f", prezzo) %></td>
      <td><%= quantita %></td>
      <td>€ <%= String.format("%.2f", subtotale) %></td>
      <td>
        <form action="RimuoviDalCarrelloServlet" method="post">
          <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
          <button type="submit">Rimuovi</button>
        </form>
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <h2>Totale carrello: € <%= String.format("%.2f", totale) %></h2>
  <form action="checkout" method="get">
    <button type="submit">Procedi al Checkout</button>
  </form>
  <% } %>

</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>