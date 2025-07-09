<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 05/07/25
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto" %>
<%@ page import="java.util.List" %>
<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    String baseURL = request.getContextPath();
%>
<html>
<head>
    <title>Categoria | Nerd House</title>
    <link rel="stylesheet" href="<%=baseURL%>/css/styles.css" type="text/css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class="catalogo">
    <h1>Prodotti per categoria</h1>

    <!-- Filtri -->
    <form method="get" action="categoria">
        <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
        <label>Lingua:
            <select name="lingua">
                <option value="">Tutte</option>
                <option value="Italiano">Italiano</option>
                <option value="Inglese">Inglese</option>
            </select>
        </label>
        <label>Editore:
            <input type="text" name="editore" placeholder="Editore...">
        </label>
        <button type="submit">Filtra</button>
    </form>

    <div class="product-grid">
        <% for (Prodotto p : prodotti) { %>
        <div class="product-card">
            <h3><%= p.getTitolo() %></h3>
            <p><%= p.getDescrizione() %></p>
            <p>Prezzo: € <%= p.getPrezzo() %></p>
            <form action="aggiungiCarrello" method="post">
                <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
                <button type="submit">Aggiungi al Carrello</button>
            </form>
        </div>
        <% } %>
    </div>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />
</body>
</html>