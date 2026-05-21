![NerdHouse Logo](src/main/webapp/images/logo.PNG)
# 🏠 NerdHouse

> Progetto universitario di e-commerce sviluppato per l'esame di **Ingegneria del Software** presso l'**Università degli Studi di Salerno (UNISA)**.

---

## 📖 Descrizione

NerdHouse è un'applicazione web di e-commerce sviluppata come progetto universitario. La piattaforma permette agli utenti di navigare un catalogo di prodotti, gestire un carrello acquisti e completare ordini, con un'architettura backend basata su Java Servlet e un database MySQL.

---

## 👥 Autori

- **Russo Gerardo**
- **Di Salvio Emanuele Luigi**
- **Greco Giuliano**

---

## 🛠️ Tecnologie Utilizzate

| Tecnologia | Versione | Ruolo |
|---|---|---|
| Java | 21 | Linguaggio principale (backend) |
| Jakarta Servlet API | 6.1.0 | Gestione delle richieste HTTP |
| Apache Tomcat | 11.x | Application server |
| MySQL Connector/J | 8.0.33 | Connessione al database |
| JSTL (Jakarta) | 2.0.0 | Template engine per le JSP |
| Gson | 2.10.1 | Serializzazione/deserializzazione JSON |
| JUnit Jupiter | 5.11.0 | Framework di testing |
| Maven | — | Build & dependency management |
| CSS | — | Stile e layout frontend |

---

## 📁 Struttura del Progetto

```
NerdHouse/
├── src/
│   └── main/
│       ├── java/          # Logica backend (Servlet, Model, DAO)
│       └── webapp/        # Frontend (JSP, CSS, risorse statiche)
├── .mvn/wrapper/          # Maven Wrapper
├── pom.xml                # Configurazione Maven
└── mvnw / mvnw.cmd        # Script Maven Wrapper (Unix/Windows)
```

---

## 🗄️ Schema del Database

Il database è composto da **11 tabelle** che coprono tutte le entità principali dell'e-commerce:

| Tabella | Descrizione |
|---|---|
| `Utente` | Dati anagrafici e credenziali degli utenti |
| `Categoria` | Categorie dei prodotti (tipo e nome) |
| `Prodotto` | Catalogo prodotti con titolo, prezzo, autore, editore, ecc. |
| `Immagine_Prodotto` | Immagini associate a ciascun prodotto |
| `Carrello` | Carrello attivo per ogni utente |
| `Contenuto_Carrello` | Prodotti presenti nel carrello con quantità |
| `Wishlist` | Lista desideri per ogni utente |
| `Contenuto_Wishlist` | Prodotti nella wishlist |
| `Ordine` | Ordini effettuati con stato e indirizzo di spedizione |
| `Contenuto_Ordine` | Dettaglio prodotti per ordine |
| `MetodiPagamento` | Metodi di pagamento salvati dall'utente |

---

## ⚙️ Prerequisiti

- **Java 21** o superiore
- **Apache Tomcat 11** (o compatibile con Jakarta Servlet 6.1)
- **MySQL** 8.x
- **Maven** 3.8+ (oppure usare il Maven Wrapper incluso)

---

## 🚀 Installazione e Avvio

### 1. Clona il repository

```bash
git clone https://github.com/RuGeR704/NerdHouse.git
cd NerdHouse
```

### 2. Configura il database

Crea il database ed esegui lo schema completo:

```sql
CREATE DATABASE nerdhouse;
USE nerdhouse;

CREATE TABLE Utente (
    ID_Utente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50),
    Cognome VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(255),
    Data_Nascita DATE,
    Indirizzo VARCHAR(255),
    Telefono VARCHAR(20)
);

CREATE TABLE Categoria (
    ID_Categoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Tipo VARCHAR(50)
);

CREATE TABLE Prodotto (
    ID_Prodotto INT PRIMARY KEY AUTO_INCREMENT,
    Titolo VARCHAR(255),
    Prezzo DECIMAL(10,2),
    Lingua VARCHAR(50),
    Autore VARCHAR(100),
    Data_Uscita DATE,
    Descrizione TEXT,
    Editore VARCHAR(100),
    Disponibilita BOOLEAN,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

CREATE TABLE Wishlist (
    ID_Wishlist INT PRIMARY KEY AUTO_INCREMENT,
    ID_Utente INT UNIQUE,
    Data_Aggiunta DATE,
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente)
);

CREATE TABLE Carrello (
    ID_Carrello INT PRIMARY KEY AUTO_INCREMENT,
    ID_Utente INT UNIQUE,
    Quantita INT,
    Totale_Spesa DECIMAL(10,2),
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente)
);

CREATE TABLE Ordine (
    ID_Utente INT,
    ID_Prodotto INT,
    Pagamento VARCHAR(50),
    Indirizzo_Ordine VARCHAR(255),
    Stato VARCHAR(50),
    PRIMARY KEY (ID_Utente, ID_Prodotto),
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

CREATE TABLE Contenuto_Wishlist (
    ID_Wishlist INT,
    ID_Prodotto INT,
    PRIMARY KEY (ID_Wishlist, ID_Prodotto),
    FOREIGN KEY (ID_Wishlist) REFERENCES Wishlist(ID_Wishlist),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

CREATE TABLE Contenuto_Carrello (
    ID_Carrello INT,
    ID_Prodotto INT,
    Quantita INT,
    PRIMARY KEY (ID_Carrello, ID_Prodotto),
    FOREIGN KEY (ID_Carrello) REFERENCES Carrello(ID_Carrello),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

CREATE TABLE MetodiPagamento (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    id_utente INT NOT NULL,
    tipo_metodo VARCHAR(50) NOT NULL,       -- Es. "Carta di credito", "PayPal"
    numero_carta_ult4 CHAR(4),              -- Ultime 4 cifre della carta
    nome_intestatario VARCHAR(100),
    scadenza CHAR(5),                       -- Formato MM/AA
    data_creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attivo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_utente) REFERENCES Utente(ID_Utente)
);

CREATE TABLE Contenuto_Ordine (
    ID_Ordine INT,
    ID_Prodotto INT,
    Quantita INT,
    PRIMARY KEY (ID_Ordine, ID_Prodotto),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);

CREATE TABLE Immagine_Prodotto (
    ID_Immagine INT PRIMARY KEY AUTO_INCREMENT,
    ID_Prodotto INT,
    Percorso_Immagine VARCHAR(255),         -- Es: '/img/prodotti/123_front.jpg'
    Ordine INT DEFAULT 1,
    Alt_Text VARCHAR(255),
    FOREIGN KEY (ID_Prodotto) REFERENCES Prodotto(ID_Prodotto)
);
```

Aggiorna le credenziali di connessione nel file di configurazione del datasource (es. `context.xml` di Tomcat o nel codice DAO).

### 3. Build del progetto

```bash
./mvnw clean package
# oppure su Windows:
mvnw.cmd clean package
```

### 4. Deploy su Tomcat

Copia il file `.war` generato nella cartella `webapps/` di Tomcat:

```bash
cp target/russo-disalvio-greco_pj-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/NerdHouse.war
```

Avvia Tomcat e accedi all'applicazione su:

```
http://localhost:8080/NerdHouse
```

---

## 🧪 Esecuzione dei Test

```bash
./mvnw test
```

---

## 📚 Contesto Accademico

Progetto sviluppato per il corso di **Ingegneria del Software** presso l'Università degli Studi di Salerno (UNISA), Anno Accademico 2024/2025.

---

## 📄 Licenza

Questo progetto è stato realizzato a scopo didattico. Tutti i diritti appartengono ai rispettivi autori.
