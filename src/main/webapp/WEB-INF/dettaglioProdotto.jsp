<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 05/07/25
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%
  Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
  String baseURL = request.getContextPath();
%>
<html>
<head>
  <title><%= prodotto.getTitolo() %> | Nerd House</title>
  <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="prodotto-dettaglio">
  <div class="prodotto-container">
    <div class="immagine-prodotto">
      <img src="<%= prodotto.getImmagine() %>" alt="Immagine prodotto" style="max-width: 300px;">
    </div>
    <div class="dettagli-prodotto">
      <h1><%= prodotto.getTitolo() %></h1>
      <p><strong>Descrizione:</strong> <%= prodotto.getDescrizione() %></p>
      <p><strong>Prezzo:</strong> € <%= String.format("%.2f", prodotto.getPrezzo()) %></p>
      <p><strong>Lingua:</strong> <%= prodotto.getLingua() %></p>
      <p><strong>Editore:</strong> <%= prodotto.getEditore() %></p>
      <p><strong>Data uscita:</strong> <%= prodotto.getDataUscita() %></p>
      <p><strong>Disponibilità:</strong>
        <% if (prodotto.isDisponibilità()) { %>
        <span style="color:green;">Disponibile</span>
        <% } else { %>
        <span style="color:red;">Non disponibile</span>
        <% } %>
      </p>

      <form action="aggiungiCarrello" method="post" style="display:inline;">
        <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
        <button type="submit">Aggiungi al Carrello</button>
      </form>

      <form action="aggiungiWishlist" method="post" style="display:inline;">
        <input type="hidden" name="idProdotto" value="<%= prodotto.getId_prodotto() %>">
        <button type="submit">Aggiungi alla Wishlist</button>
      </form>
    </div>
  </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>