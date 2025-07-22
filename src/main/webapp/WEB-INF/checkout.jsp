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
<%@ page import="Model.ImmagineProdotto" %>
<%@ page import="Model.MetodoPagamento" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  List<Prodotto> prodottiCarrello = (List<Prodotto>) request.getAttribute("prodottiCarrello");
  Float totale = (Float) request.getAttribute("totale");
  List<MetodoPagamento> metodi = (List<MetodoPagamento>) request.getAttribute("metodi");

  if (prodottiCarrello == null || prodottiCarrello.isEmpty()) {
    System.out.println("<p>Il carrello è vuoto. Non puoi procedere con il checkout.</p>");
    return;
  }
%>
<html>
<head>
  <title>Checkout | Nerd House</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body style="background-color: #121212;">
<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="checkout">
  <h1 style="text-align: center; color: gold; text-decoration: underline; text-decoration-color: #aa0000">Conferma Ordine</h1>
  <div class="content">

    <h2>Riepilogo Carrello</h2>
    <ul class="carrello-list">
      <% for (Prodotto p : prodottiCarrello) { %>
      <li class="carrello-item">
        <div class="prodotto-info">
          <%
            List<ImmagineProdotto> immagini = new Model.ImmagineProdottoDAO().doRetrieveByProdotto(p.getId_prodotto());
            if (immagini != null && !immagini.isEmpty()) {
              ImmagineProdotto img = immagini.getFirst();
          %>
          <div><img class="img-prodotto" src="<%= request.getContextPath() + img.getPercorsoImmagine() %>" style="height: 120px; width: auto;" /></div>
          <%
          } else {
          %>
          <div><img src="../images/default.jpg" style="height: 120px; width: auto;"/></div>
          <% } %>
          <div class="prodotto-dettagli">
            <strong><%= p.getTitolo() %></strong>
            <p style="color: darkred; font-size: 16px; text-align: left; font-weight: bold">€ <%= String.format("%.2f", p.getPrezzo()) %></p>
          </div>
        </div>
      </li>
      <% } %>
    </ul>
  <p style="color: darkred"><strong>Totale: € <%= String.format("%.2f", totale) %></strong></p>

    <form action="checkout" method="post">
      <h2>Metodo di pagamento:</h2><br>
    <c:choose>
      <c:when test="${not empty metodi}">
        <table border="1" cellpadding="5" cellspacing="0">
          <thead>
          <tr>
            <th>Tipo</th>
            <th>Ultime 4 cifre</th>
            <th>Intestatario</th>
            <th>Scadenza</th>
            <th>Stato</th>
            <th>Usa</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="metodo" items="${metodi}">
            <tr>
              <td>${metodo.tipoMetodo}</td>
              <td>${metodo.numeriFinaliCarta}</td>
              <td>${metodo.nomeIntestatario}</td>
              <td>${metodo.scadenza}</td>
              <td class="${metodo.attivo ? 'status-attivo' : 'status-disattivo'}">
                <c:choose>
                  <c:when test="${metodo.attivo}">Attivo</c:when>
                  <c:otherwise>Disattivato</c:otherwise>
                </c:choose>
              </td>
              <td>
                <input type="radio" name="pagamento" value="${metodo.numeriFinaliCarta}" required />
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </c:when>
      <c:otherwise>
        <p>Non hai metodi di pagamento registrati.</p>
      </c:otherwise>
    </c:choose>

    <br><br>

    <button id="aggiungiMetodoPagamento" onclick="aggiuntaMetodoPagamento()">Aggiungi Metodo di Pagamento</button>

<br>
  <h2>Dati per la spedizione:</h2> <br>
    <input type="text" name="indirizzo" id="indirizzo" placeholder="Inserisci il tuo indirizzo" required> <br><br><br>
    <button type="submit">Conferma Ordine</button>
  </form>

    <div id="overlayForm" style="display: none">

      <div style="background-color: white;
                            width: 400px;
                            margin: 15px auto;
                            padding: 20px;
                            border-radius: 10px;
                            box-shadow: 0 0 10px rgba(0,0,0,0.3);
                            position: relative;
                            top: 50px;">

        <h3>Aggiungi Metodo di Pagamento</h3>

        <form action="aggiungiPagamento" method="post">

          <img src="${pageContext.request.contextPath}/images/pagamenti.jpg">

          <a href="https://www.paypal.com/auth"><img src="${pageContext.request.contextPath}/images/paypal.png" title="Paga con PayPal"></a>


          <label for="numeroCarta">Numero Carta:</label><br>
          <input type="text" id="numeroCarta" name="numeroCarta" maxlength="19" pattern="\d{13,19}" required placeholder="Inserisci numero carta completo"><br><br>

          <label for="nomeIntestatario">Nome Intestatario:</label><br>
          <input type="text" id="nomeIntestatario" name="nomeIntestatario" placeholder="Mario Rossi" required><br><br>

          <label for="scadenza">Scadenza (MM/AA):</label><br>
          <input type="text" id="scadenza" name="scadenza" pattern="(0[1-9]|1[0-2])\/\d{2}" placeholder="MM/AA" required><br><br>

          <button type="submit">Salva</button>
          <button type="button" onclick="annullaAggiuntaPagamento()">Annulla</button>
        </form>
      </div>
    </div>

  </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

<script>
  function aggiuntaMetodoPagamento() {
    document.getElementById("overlayForm").style.display = "block";
  }

  function annullaAggiuntaPagamento() {
    document.getElementById("overlayForm").style.display = "none";
  }

  window.onclick = function(event) {
    const overlay = document.getElementById("overlayForm");
    if (event.target === overlay) {
      annullaAggiuntaPagamento();
    }
  }

</script>
</body>
</html>