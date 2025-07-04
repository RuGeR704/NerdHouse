<%--
  Created by IntelliJ IDEA.
  User: Rafus
  Date: 23/06/2025
  Time: 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Area Utente | NerdHouse</title>
    <link rel="stylesheet" href="./css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

    <header>
        <div class="logo">
            <a href="index.html"><img src="./images/logo.PNG" title="logo"></a>
        </div>

        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Cerca...">
        </div>

        <div class="header-botton">
            <div class="botton-item">
                <a href="userServlet"><i class="fas fa-user user-icon" title="Accedi"></i></a>
                <span class="botton-label">Accedi</span>
            </div>

            <div class="botton-item">
                <a href="#"><i class="fas fa-star" title="Wishlist"></i></a>
                <span class="botton-label">Wishlist</span>
            </div>

            <div class="botton-item">
                <a href="#"><i class="fas fa-shopping-cart" title="Carrello"></i></a>
                <span class="botton-label">Carrello</span>
            </div>
        </div>
    </header>

    <div class="user-area">

        <nav class="user-menu">
            <h2>Ciao, ${utente.nome}</h2>
            <ul>
                <li><a href="#" onclick="showSection('dati')">Dati personali</a></li>
                <li><a href="#" onclick="showSection('ordini')">I miei ordini</a></li>
                <li><a href="#" onclick="showSection('pagamenti')">Metodi di pagamento</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>

        <div class="content">
            <section id="dati" class="dati-personali">

                <h3>Dati personali</h3>

                <div id="dati-statici">
                    <p><strong>Nome:</strong> ${utente.nome}</p>
                    <p><strong>Cognome:</strong> ${utente.cognome}</p>
                    <p><strong>Email:</strong> ${utente.email}</p>
                    <p><strong>Data di Nascita:</strong> ${utente.dataNascita}</p>
                    <p><strong>Telefono:</strong> ${utente.telefono}</p>

                    <button onclick="mostraForm()">Modifica</button>
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
                    <button type="button" onclick="annullaModifica()">Annulla</button>
                </form>
            </section>

            <section id="ordini">
                <h3>I tuoi ordini</h3>

                <p>Qui compariranno i tuoi ordini.</p>
            </section>

            <section id="pagamenti">
                <h3>I tuoi metodi di pagamento</h3>

                <p>Qui compariranno i tuoi metodi di pagamento</p>
            </section>

        </div>
    </div>

    <footer class="site-footer">
        <div class="footer-content">
            <p>&copy; 2025 Nerd House | Tutti i diritti riservati.</p>
        </div>
    </footer>

    <script>
        function showSection(id) {
            const sections = document.querySelectorAll('.content section');
            sections.forEach(section => section.style.display = 'none');
            document.getElementById(id).style.display = 'block';
        }

        // Mostra la prima sezione all'avvio
        window.onload = function () {
            showSection('dati');
        };

        function mostraForm() {
            document.getElementById("dati-statici").style.display = "none";
            document.getElementById("dati-form").style.display = "block";
        }

        function annullaModifica() {
            document.getElementById("dati-form").reset(); // Reset del form
            document.getElementById("dati-form").style.display = "none";
            document.getElementById("dati-statici").style.display = "block";
        }
    </script>

</body>
</html>
