function sortTableByCost(table) {
  const tBody = table.tBodies[0];
  const rows = Array.from(tBody.querySelectorAll('tr'));

  const sortedRows = rows.sort((a, b) => {
    const aCost = parseFloat(a.getElementsByTagName('td')[1].textContent.substring(1));
    const bCost = parseFloat(b.getElementsByTagName('td')[1].textContent.substring(1));
    return aCost - bCost;
  });

  tBody.append(...sortedRows);
}

function chackAffordableItems(budget, table) {
  const rows = table.getElementsByTagName('tr');
  for (let i = 1; i < rows.length; i++) {
    const row = rows[i];
    const cells = row.getElementsByTagName('td');

    if (cells.length >= 2) {
      const cost = parseFloat(cells[1].textContent.substring(1));
      const checkbox = cells[2].querySelector('input[type="checkbox"]');

      if (cost <= budget) {
        checkbox.checked = true;
        budget -= cost;
      } else {
        checkbox.checked = false;
      }
    }
  }
}

//  Optimize list
function optimize() {
  const budget = parseFloat(document.getElementById('budget').value);
  document.getElementById('title-budget').innerHTML = budget;

  if(isNaN(budget)) return;

  const table = document.querySelector('table');
  sortTableByCost(table);

  // Clean forms fields
  document.getElementById('budget').value = '';
  $('#modalOptimize').modal('hide');
  chackAffordableItems(budget, table);
}

// Function to add a new item on table
function addItem() {
  const description = document.getElementById('description').value;
  const cost = document.getElementById('cost').value;

  if (!description.length || isNaN(cost)) return;

  const table = document.querySelector('table');
  const row = table.insertRow();

  // Insert data
  const cell1 = row.insertCell(0);
  cell1.innerHTML = description;

  const cell2 = row.insertCell(1);
  cell2.innerHTML = `$ ${cost}`;

  const cell3 = row.insertCell(2);
  cell3.innerHTML = '<input type="checkbox">';

  // Clean forms fields
  document.getElementById('description').value = '';
  document.getElementById('cost').value = '';

  $('#modalCreate').modal('hide');

  saveNewRow();
}

function saveNewRow(){
  const table = document.querySelector('#table tbody');
  const lastRow = table.lastElementChild;

  if (lastRow) {
    const name = lastRow.cells[0].textContent;
    const cost = lastRow.cells[1].textContent;
    const completed = lastRow.cells[2].querySelector('input').checked;

    const data = JSON.parse(localStorage.getItem('wishlistData')) || [];
    data.push({ name, cost, completed });
    localStorage.setItem('wishlistData', JSON.stringify(data));
  }
  attachCheckboxEventListeners();
}

function insertSavedRows(tableBody, savedRows) {
  savedRows.forEach((item) => {
    const newRow = document.createElement('tr');
    newRow.innerHTML = `
      <td>${item.name}</td>
      <td>${item.cost}</td>
      <td><input type="checkbox" ${item.completed ? 'checked' : ''}></td>`;
    tableBody.appendChild(newRow);
  });
  attachCheckboxEventListeners();
}

// Function to load table data from localStorage and populate the table
function loadTableData() {
  const savedData = localStorage.getItem('wishlistData');

  if (savedData) {
    const data = JSON.parse(savedData);
    const tableBody = document.querySelector('#table tbody');
    tableBody.innerHTML = '';

    insertSavedRows(tableBody, data);
  } else {
    const tableBody = document.querySelector('#table tbody');

    // Hardcoded rows
    const hardcodedData = [
      { name: 'Ruby Metaprogramming Book', cost: '$ 500', completed: false },
      { name: 'MacBook Pro', cost: '$ 1300', completed: false },
      { name: 'Electric Bike', cost: '$ 670', completed: false },
      { name: 'Sennheiser Headphones', cost: '$ 180', completed: false },
      { name: 'home Brew Beer Kit', cost: '$ 320', completed: false },
      { name: 'asdasd', cost: '$ 320', completed: false },
    ];
    localStorage.setItem('wishlistData', JSON.stringify(hardcodedData));

    insertSavedRows(tableBody, hardcodedData);
  }
}

// Load data from localStorage when the page loads
loadTableData();

function attachCheckboxEventListeners() {
  const checkboxes = document.querySelectorAll('#table tbody input[type="checkbox"]');

  checkboxes.forEach((checkbox, index) => {
    checkbox.addEventListener('change', () => {
      const savedData = localStorage.getItem('wishlistData');

      if (savedData) {
        const data = JSON.parse(savedData);
        data[index].completed = checkbox.checked;
        localStorage.setItem('wishlistData', JSON.stringify(data));
      }
    });
  });
}
