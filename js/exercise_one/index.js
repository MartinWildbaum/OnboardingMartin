function sortTableByCost(table) {

  const tBody = table.tBodies[0];
  const rows = Array.from(tBody.querySelectorAll("tr"));

  const sortedRows = rows.sort((a, b) => {
    const aCost = parseFloat(a.querySelector(`td:nth-child(${ 1 + 1})`).textContent.substring(1));
    const bCost = parseFloat(b.querySelector(`td:nth-child(${ 1 + 1})`).textContent.substring(1));
    return aCost >= bCost ? 1 : -1;
  });

  while(tBody.firstChild){ // ACA SE TRANCA
    tBody.removeChild(tBody.firstChild);
  }
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
        console.log("entro");
      } else {
        checkbox.checked = false;
        break;
      }
    }
  }
}

//  Optimize list
function optimize() {

  const budget = parseFloat(document.getElementById('budget').value);
  document.getElementById('title-budget').innerHTML = budget;

  if (isNaN(budget)) {
    // Do nothing
    return;
  }

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

  if (!description.length || isNaN(cost)) {
    // Do nothing
    return;
  }

  const table = document.querySelector('table');
  const row = table.insertRow();

  // Insert data
  const cell1 = row.insertCell(0);
  cell1.innerHTML = description;

  const cell2 = row.insertCell(1);
  cell2.innerHTML = "$ " + cost;

  const cell3 = row.insertCell(2);
  cell3.innerHTML = '<input type="checkbox">';

  // Clean forms fields
  document.getElementById('description').value = '';
  document.getElementById('cost').value = '';

  $('#modalCreate').modal('hide');
}
