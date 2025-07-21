<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 20/07/25
  Time: 19:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.Prodotto, java.util.List" %>
<%
    List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
    List<String> tipi = (List<String>) request.getAttribute("tipi");
    List<String> editori = (List<String>) request.getAttribute("editori");
    List<String> autori = (List<String>) request.getAttribute("autori");
    List<Boolean> disponibilita = (List<Boolean>) request.getAttribute("disponibilita");
    String baseURL = request.getContextPath();
%>
<html>
<head>
    <title>Fumetti | Nerd House</title>
    <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<main style="display: flex; margin: 40px;">
    <!-- Sidebar Filtri -->
    <aside style="width: 20%; padding: 20px; background: #f1f1f1; border-radius: 10px; margin-right: 20px;">
        <h2>Filtro</h2>
        <form action="categoria" method="get">
            <input type="hidden" name="categoria" value="fumetti">

            <label>Tipo:</label>
            <select name="tipo">
                <option value="">Tutti</option>
                <% if (tipi != null) for (String tipo : tipi) { %>
                <option value="<%= tipo %>" <%= tipo.equals(request.getParameter("tipo")) ? "selected" : "" %>><%= tipo %></option>
                <% } %>
            </select><br><br>

            <label>Prezzo (min):</label>
            <input type="number" name="prezzoMin" step="0.01" value="<%= request.getParameter("prezzoMin") != null ? request.getParameter("prezzoMin") : "" %>"><br><br>

            <label>Prezzo (max):</label>
            <input type="number" name="prezzoMax" step="0.01" value="<%= request.getParameter("prezzoMax") != null ? request.getParameter("prezzoMax") : "" %>"><br><br>

            <label>Lingua:</label>
            <select name="lingua">
                <option value="">Tutte</option>
                <option value="Italiano" <%= "Italiano".equals(request.getParameter("lingua")) ? "selected" : "" %>>Italiano</option>
                <option value="Inglese" <%= "Inglese".equals(request.getParameter("lingua")) ? "selected" : "" %>>Inglese</option>
            </select><br><br>

            <label>Editore:</label>
            <select name="editore">
                <option value="">Tutti</option>
                <% if (editori != null) for (String editore : editori) { %>
                <option value="<%= editore %>" <%= editore.equals(request.getParameter("editore")) ? "selected" : "" %>><%= editore %></option>
                <% } %>
            </select><br><br>

            <label>Autore:</label>
            <select name="autore">
                <option value="">Tutti</option>
                <% if (autori != null) for (String autore : autori) { %>
                <option value="<%= autore %>" <%= autore.equals(request.getParameter("autore")) ? "selected" : "" %>><%= autore %></option>
                <% } %>
            </select><br><br>

            <label>Disponibilità:</label>
            <select name="disponibilita">
                <option value="">Tutte</option>
                <% if (disponibilita != null) {
                    for (Boolean disp : disponibilita) {
                        String dispVal = disp.toString();
                        String text = disp ? "Disponibile" : "Non disponibile";
                %>
                <option value="<%= dispVal %>" <%= dispVal.equals(request.getParameter("disponibilita")) ? "selected" : "" %>><%= text %></option>
                <% } } %>
            </select><br><br>

            <button type="submit">Filtra</button>
        </form>
    </aside>

    <!-- Prodotti -->
    <section style="flex: 1; display: flex; flex-wrap: wrap; gap: 20px;">
        <% if (prodotti != null && !prodotti.isEmpty()) {
            for (Prodotto p : prodotti) { %>
        <div class="product-card" style="border: 1px solid #ccc; padding: 15px; width: 200px; border-radius: 10px;">
            <img src="<%= baseURL %>/img/prodotti/<%= p.getId_prodotto() %>.jpg" alt="<%= p.getTitolo() %>" style="width: 100%; height: auto; border-radius: 5px;">
            <h3><%= p.getTitolo() %></h3>
            <p style="font-size: 14px;"><%= p.getDescrizione() %></p>
            <p style="font-weight: bold;">€ <%= String.format("%.2f", p.getPrezzo()) %></p>
            <% if (p.isDisponibilità()) { %>
            <p style="color: green; font-weight: bold;">Disponibile</p>
            <% } else { %>
            <p style="color: red; font-weight: bold;">Non disponibile</p>
            <% } %>
            <form action="aggiungiCarrello" method="post">
                <input type="hidden" name="idProdotto" value="<%= p.getId_prodotto() %>">
                <button type="submit">Aggiungi al Carrello</button>
            </form>
        </div>
        <% } } else { %>
        <p>Nessun prodotto trovato.</p>
        <% } %>
    </section>
</main>

<jsp:include page="/WEB-INF/fragments/footer.jsp"/>

</body>
</html>