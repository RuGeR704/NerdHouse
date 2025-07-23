<%--
  Created by IntelliJ IDEA.
  User: giuliano20
  Date: 23/07/25
  Time: 02:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, Model.Prodotto, Model.Categoria" %>
<%
  List<Prodotto> prodotti = (List<Prodotto>) request.getAttribute("prodotti");
  List<String> editori = (List<String>) request.getAttribute("editori");
  List<String> autori = (List<String>) request.getAttribute("autori");
  List<String> tipi = (List<String>) request.getAttribute("tipi");
  List<String> lingue = (List<String>) request.getAttribute("lingue");
  List<String> disponibilita = (List<String>) request.getAttribute("disponibilita");
  Categoria categoria = (Categoria) request.getAttribute("categoria");

  String filtroEditore = request.getParameter("editore");
  String filtroAutore = request.getParameter("autore");
  String filtroTipo = request.getParameter("tipo");
  String filtroDisponibilita = request.getParameter("disponibilita");
  String filtroPrezzoMin = request.getParameter("prezzoMin");
  String filtroPrezzoMax = request.getParameter("prezzoMax");
  String filtroLingua = request.getParameter("lingua");

  String baseURL = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>Novità | Nerd House</title>
  <link rel="stylesheet" href="<%= baseURL %>/css/styles.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp"/>

<div class="container-shop">
  <aside class="filters">
    <form action="categoria" method="get">
      <input type="hidden" name="categoria" value="novita">

      <h3>Filtri</h3>

      <label>Tipo:</label>
      <select name="tipo">
        <option value="">Tutti</option>
        <% for (String tipo : tipi) { %>
        <option value="<%= tipo %>" <%= tipo.equals(filtroTipo) ? "selected" : "" %>><%= tipo %></option>
        <% } %>
      </select>

      <label>Prezzo Min:</label>
      <input type="number" step="0.01" name="prezzoMin" value="<%= filtroPrezzoMin != null ? filtroPrezzoMin : "" %>">

      <label>Prezzo Max:</label>
      <input type="number" step="0.01" name="prezzoMax" value="<%= filtroPrezzoMax != null ? filtroPrezzoMax : "" %>">

      <label>Lingua:</label>
      <select name="lingua">
        <option value="">Tutte</option>
        <% for (String lingua : lingue) { %>
        <option value="<%= lingua %>" <%= lingua.equals(filtroLingua) ? "selected" : "" %>><%= lingua %></option>
        <% } %>
      </select>

      <label>Editore:</label>
      <select name="editore">
        <option value="">Tutti</option>
        <% for (String editore : editori) { %>
        <option value="<%= editore %>" <%= editore.equals(filtroEditore) ? "selected" : "" %>><%= editore %></option>
        <% } %>
      </select>

      <label>Autore:</label>
      <select name="autore">
        <option value="">Tutti</option>
        <% for (String autore : autori) { %>
        <option value="<%= autore %>" <%= autore.equals(filtroAutore) ? "selected" : "" %>><%= autore %></option>
        <% } %>
      </select>

      <label>Disponibilità:</label>
      <select name="disponibilita">
        <option value="">Tutte</option>
        <% for (String disp : disponibilita) { %>
        <option value="<%= disp %>" <%= disp.equals(filtroDisponibilita) ? "selected" : "" %>><%= disp %></option>
        <% } %>
      </select>

      <button type="submit" class="btn-filtra">Filtra</button>
    </form>
  </aside>

  <section class="products">
    <h2>Novità</h2>
    <div class="product-grid">
      <% for (Prodotto p : prodotti) { %>
      <div class="product-card">
        <a href="prodotto?id=<%= p.getId_prodotto() %>">
          <div class="product-img" id="img-<%= p.getId_prodotto() %>"></div>
          <div class="product-info">
            <h4><%= p.getTitolo() %></h4>
            <p><%= p.getPrezzo() %> €</p>
            <p class="availability <%= p.isDisponibilità() ? "green" : "red" %>">
              <%= p.isDisponibilità() ? "Disponibile" : "Non disponibile" %>
            </p>
            </p>
            </p>
          </div>
        </a>
      </div>
      <% } %>
    </div>
  </section>
</div>

<jsp:include page="/WEB-INF/fragments/footer.jsp"/>

<script>
  const immaginiProdotti = {
  <% for (Prodotto p : prodotti) { %>
  <%= p.getId_prodotto() %>: "<%= baseURL %>/img/prodotti/<%= p.getId_prodotto() %>_1.jpg",
  <% } %>
  };

  window.onload = () => {
    for (const [id, url] of Object.entries(immaginiProdotti)) {
      const imgDiv = document.getElementById("img-" + id);
      if (imgDiv) {
        imgDiv.style.backgroundImage = `url(${url})`;
        imgDiv.style.backgroundSize = "cover";
        imgDiv.style.backgroundPosition = "center";
      }
    }
  };
</script>

</body>
</html>
