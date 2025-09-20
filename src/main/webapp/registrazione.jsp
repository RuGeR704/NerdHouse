<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Registrazione | Nerd House</title>
    <link rel="stylesheet" href="./css/styles.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<jsp:include page="/WEB-INF/fragments/header.jsp" />

<main class ="login-page">
    <div class="register-container">
<form action="servlet-registrazione" method="POST">
    <h1>Registrazione</h1>

    <h2>Dati Anagrafici</h2>

    <input type="text" id="nome" name="nome" placeholder="Nome" required><br><br>

    <input type="text" id="cognome" name="cognome" placeholder="Cognome" required><br><br>

    <h2>Dati di accesso</h2>

    <input type="email" id="email" name="email" placeholder="E-Mail" required><br><br>

    <input type="password" id="password" name="password" placeholder="Password" required><br><br>

    <h2>Informazioni Personali</h2>

    <label for="dataNascita">Data di Nascita</label>
    <input type="date" id="dataNascita" name="dataNascita" required><br><br>

    <label for="indirizzo">Indirizzo</label>
    <input type="text" id="indirizzo" name="indirizzo" placeholder="Via/Numero/Città/Provincia/CAP" required><br><br>

    <label for="telefono">Numero di telefono</label><br>
    <input type="tel" id="telefono" name="telefono" placeholder="+39 XXXXXXXXXX" required><br><br>

    <button type="submit">Invia</button>
</form>
    </div>
    </main>

<jsp:include page="/WEB-INF/fragments/footer.jsp" />

</body>
</html>

