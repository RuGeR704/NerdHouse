<!DOCTYPE html>
<html lang="it">
<head>
  <!-- imposta caratteri accentati -->
  <meta charset="UTF-8">
  <title>NERD HOUSE</title>

  <style>
    .title-container {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;  /* spazio tra elementi */
      margin: 40px 40px 0 40px;
    }

    .info { /* barra info */
      background-color: black;
      color: white;
      border: black;
      border-radius: 15px;
      padding: 15px;
      width: 1230px;
      margin: 5px auto;
      font-family: Arial, sans-serif;
      word-spacing: 20px;
    }

    .title-box { /* box nera titolo */
      border: 3px solid black;
      padding: 20px 40px;
      border-radius: 10px;
      background-color: black;
    }

    .nerd {
      color: yellow; /* colore "NERD" */
    }

    .house {
      color: red; /* colore "HOUSE" */
    }

    h1 { /* titolo principale */
      font-size: 3em;
      font-family: Arial, sans-serif;
      margin: 0;
    }

    img.logo-home {
      width: 130px;
    }

    img.account-icon { /* icona */
      width: 150px;
      cursor: pointer;
    }

    a.account-link {
      display: flex;
      align-items: center;
    }

    .search-container { /* barra nera per info */
      margin: 30px auto;
      width: 320px;
      text-align: center;
    }

    input[type="text"] {  /*barra di ricerca*/
      border: 1px solid #555;
      width: 320px;
      padding: 10px 10px 10px 40px;
      font-size: 1em;
      border-radius: 5px;
      background-image: url('https://cdn-icons-png.flaticon.com/512/622/622669.png');
      background-repeat: no-repeat;
      background-size: 20px 20px;
      background-position: 10px center;
    }

    .tag-filter {
      margin: 20px 0;
      text-align: center;
    }

    .tag-filter button {
      margin: 5px;
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      background-color: #ddd;
      cursor: pointer;
      font-weight: bold;
    }

    .tag-filter button.active {
      background-color: #333;
      color: white;
    }

    ul#resultList { /*richiude tutto tra quadrati*/
      margin: 20px 40px;
      padding: 0;
      list-style: none;
      font-family: Arial, sans-serif;
      display: flex;
      flex-wrap: wrap; /* permette di andare a capo se la riga non basta */
      gap: 20px;
    }

    ul#resultList li {  /* impostazioni del rettangolo dei prodotti */
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 10px;
      border: 1px solid #ccc;
      border-radius: 10px;
      padding: 10px;
      width: 200px;
      background-color: #f9f9f9;
      box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
    }

    ul#resultList img { /* impostazioni immagini prodotto */
      width: 150px;
      height: auto;
      border-radius: 5px;
    }

    a.product-link {
      text-decoration: none;
      color: inherit;
    }
  </style>
</head>

<body>

<div class="info"> <!-- barra di info -->
  <span id="telefono" style="color:white; cursor:pointer; text-decoration:underline;">Telefono</span>
  <a href="mailto:nerdhouse@email.com" style="color:white; cursor:pointer;">Email</a>
</div>

<div class="title-container"> <!-- logo sito -->
  <img class="logo-home" src="" alt="Logo Nerd House">
  <div class="title-box">
    <h1><span class="nerd">NERD</span> <span class="house">HOUSE</span></h1>
  </div>
  <!-- logo account -->
  <a href="userServlet" class="account-link">
    <img class="account-icon" src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="Account">
  </a>
</div>

<div class="search-container">
  <input type="text" id="searchInput" placeholder="Cerca nella lista...">
</div>

<ul id="resultList"> <!-- lista prodotti -->

  <!-- prodotto 1 -->
  <li data-tags="maglietta starwars">
    <a href="maglietta_starwars.jsp" class="product-link"> <!-- pagina dedicata -->
      <img src="https://png.pngtree.com/png-vector/20241102/ourmid/pngtree-premium-black-t-shirt-mockup-png-image_14226805.png" alt="T-shirt Star Wars">
      <div>
        <strong>T-shirt Star Wars</strong><br>
        <small>€19.99</small>
      </div>
    </a>
  </li>

  <!-- prodotto 2 -->
  <li data-tags="maglietta starwars">
    <a href="maglietta_starwars.jsp" class="product-link">
      <img src="https://png.pngtree.com/png-vector/20241102/ourmid/pngtree-premium-black-t-shirt-mockup-png-image_14226805.png" alt="Maglietta">
      <div>
        <strong>Maglietta</strong><br>
        <small>€19.99</small>
      </div>
    </a>
  </li>

</ul>

<div class="tag-filter"> <!-- filtri -->
  <button data-filter="all" class="active">Tutti</button>
  <button data-filter="maglietta">Magliette</button>
  <button data-filter="starwars">Star Wars</button>
  <button data-filter="accessori">Accessori</button>
</div>

<script>
  // script per filtro tag e ricerca
  const searchInput = document.getElementById('searchInput'); // input barra di ricerca
  const buttons = document.querySelectorAll('.tag-filter button');
  const listItems = document.querySelectorAll('#resultList li'); // prende tutto cio che sta nel id=resultlist
  let activeTag = 'all';

  buttons.forEach(btn => { // mette attivo il pulsante che noi usiamo
    btn.addEventListener('click', () => {
      buttons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      activeTag = btn.dataset.filter;
      filterItems();
    });
  });

  searchInput.addEventListener('input', filterItems);

  function filterItems() {
    const q = searchInput.value.toLowerCase();
    listItems.forEach(li => {
      const textMatch = li.textContent.toLowerCase().includes(q);
      const tags = li.dataset.tags.split(' ');
      const tagMatch = (activeTag === 'all' || tags.includes(activeTag));
      li.style.display = (textMatch && tagMatch) ? '' : 'none';
    });
  }
</script>

<script>
  // script telefono
  document.getElementById('telefono').onclick = function() {
    alert('Il nostro numero è: +39 089 456 7890');
  }
</script>

</body>
</html>
