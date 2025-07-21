<%@ page import="Model.MetodoPagamento" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Rafus
  Date: 23/06/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Area Utente | NerdHouse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<%
    String sezione = (String) request.getAttribute("sezione");
    if (sezione == null) sezione = "dati";
%>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

    <div class="user-area">

        <nav class="user-menu">
            <h2>Ciao, ${utente.nome}</h2>
            <ul>
                <li><a href="?sezione=dati">Dati personali</a></li>
                <li><a href="?sezione=ordini">I miei ordini</a></li>
                <li><a href="?sezione=wishlist">Wishlist</a></li>
                <li><a href="?sezione=pagamenti">Metodi di pagamento</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>

        <div class="content">
            <section id="dati" class="dati-personali" style="display: <%= sezione.equals("dati") ? "block" : "none" %>;">

                <h3>Dati personali</h3>

                <div id="dati-statici">
                    <p><strong>Nome:</strong> ${utente.nome}</p>
                    <p><strong>Cognome:</strong> ${utente.cognome}</p>
                    <p><strong>Email:</strong> ${utente.email}</p>
                    <p><strong>Data di Nascita:</strong> <span id="dataNascita" data-date="${utente.dataNascita}"></span> </p>
                    <p><strong>Telefono:</strong> ${utente.telefono}</p>

                    <button onclick="mostraForm()">Modifica Dati Personali</button> <br> <br>
                    <button id="bottonePassword" onclick="mostraPasswordChange()">Modifica Password</button>

                </div>

                <form id="dati-form" action="aggiornaUtente" method="post" style="display: none">
                    <div class="form-box">
                        <label><strong>Nome</strong></label> <br>
                        <input type="text" name="nome" value="${utente.nome}" required>
                    </div>
                    <div class="form-box">
                        <label><strong>Cognome</strong></label> <br>
                        <input type="text" name="cognome" value="${utente.cognome}" required>
                    </div>
                    <div class="form-box">
                        <label><strong>Email</strong></label> <br>
                        <input type="email" name="email" value="${utente.email}" required>
                    </div>
                    <div class="form-box">
                        <label><strong>Data di Nascita</strong></label> <br>
                        <input type="date" name="dataNascita" value="${utente.dataNascita}" required>
                    </div>
                    <div class="form-box">
                        <label><strong>Telefono</strong></label> <br>
                        <input type="text" name="telefono" value="${utente.telefono}">
                    </div>
                    <button type="submit">Salva modifiche</button>
                    <button type="button" onclick="annullaModificaDati()">Annulla</button>
                </form>

            <form id="password-form" action="aggiornaPassword" method="post" style="display: none;">

                <label><strong>Password attuale:</strong></label> <br>
                <input type="password" id="old-pass" name="old-pass"> <br> <br>

                <label><strong>Nuova Password:</strong></label> <br>
                <input type="password" id="new-pass" name="new-pass"> <br> <br>

                <button type="submit">Salva modifiche</button>
                <button type="button" onclick="annullaModificaPassword()">Annulla</button>

            </form>

            <% String esito = (String) request.getAttribute("esito");
                if (esito != null) { %>
            <p><%= esito %></p>
            <% } %>

            </section>

            <section id="wishlist" style="display: <%= sezione.equals("wishlist") ? "block" : "none" %>;">
                <h3>La tua Wishlist</h3>

                <%if(sezione != null && sezione.equals("wishlist")) {%>
                    <jsp:include page="wishlist.jsp" />
                <% } %>
            </section>

            <section id="ordini" style="display: <%= sezione.equals("ordini") ? "block" : "none" %>;">
                <h3>I tuoi ordini</h3>

                <jsp:include page="ordini.jsp" />

            </section>

            <section id="pagamenti" style="display: <%= sezione.equals("pagamenti") ? "block" : "none" %>;">
                <h3>I tuoi metodi di pagamento</h3>

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
                                <th>Azione</th>
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
                                        <form action="rimuoviMetodoPagamento" method="post" onsubmit="return confirm('Sei sicuro di voler cancellare questo metodo di pagamento?');">
                                            <input type="hidden" name="idMetodo" value="${metodo.id_metodo}" />
                                            <button id="cancellaPagamento" type="submit">Cancella</button>
                                        </form>
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

                <br>

                <button id="aggiungiMetodoPagamento" onclick="aggiuntaMetodoPagamento()">Aggiungi Metodo di Pagamento</button>

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
            </section>

        </div>
    </div>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

    <script>
        function showSection(id) {
            const sections = document.querySelectorAll('.content section');
            sections.forEach(section => section.style.display = 'none');
            document.getElementById(id).style.display = 'block';
        }


        function mostraForm() {
            document.getElementById("dati-statici").style.display = "none";
            document.getElementById("dati-form").style.display = "block";
        }

        function annullaModificaDati() {
            document.getElementById("dati-form").reset(); // Reset del form
            document.getElementById("dati-form").style.display = "none";
            document.getElementById("dati-statici").style.display = "block";
        }

        function annullaModificaPassword() {
            document.getElementById("password-form").reset(); // Reset del form
            document.getElementById("password-form").style.display = "none";
            document.getElementById("dati-statici").style.display = "block";
            document.getElementById("bottonePassword").style.display = "block";
        }

        function mostraPasswordChange() {
            document.getElementById("password-form").style.display = "block";
            document.getElementById("dati-statici").style.display = "block";
            document.getElementById("bottonePassword").style.display = "none";
        }

            const el = document.getElementById("dataNascita");
            const date = new Date(el.dataset.date);
            el.textContent = date.toLocaleDateString("it-IT");

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
