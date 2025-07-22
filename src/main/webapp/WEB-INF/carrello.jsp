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
<%@ page import="Model.ImmagineProdotto" %>
<%
  List<ContenutoCarrello> contenuti = (List<ContenutoCarrello>) request.getAttribute("contenuti");
  String baseURL = request.getContextPath();
  double totale = 0;
%>
<html>
<head>
  <title>Carrello | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="content">
  <h1>Il tuo Carrello</h1>

  <% if (contenuti == null || contenuti.isEmpty()) { %>
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
    <% for (ContenutoCarrello item : contenuti) {
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
        <%
          List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(prodotto.getId_prodotto());
          if (immagini != null && !immagini.isEmpty()) {
            ImmagineProdotto img = immagini.getFirst();
        %>
        <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="height: 120px; width: auto;" /></div>
        <%
            } else {
        %>
        <div><img src="<%= baseURL %>/images/default.jpg" style="height: 120px; width: auto;"/></div>
        <% } %>
      </td>
      <td>€ <%= String.format("%.2f", prezzo) %></td>
      <td><%= quantita %></td>
      <td>€ <%= String.format("%.2f", subtotale) %></td>
      <td>
        <form action="rimuoviDalCarrello" method="post">
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

<script>

  //Slider immagini
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".my-slider").forEach(slider => {
      tns({
        container: slider,
        items: 1,
        slideBy: "page",
        autoplay: true,
        controls: true,
        nav: false,
        autoplayButtonOutput: false,
        controlsText: ['&#10094;', '&#10095;']
      });
    });
  });
</script>

</body>
</html>