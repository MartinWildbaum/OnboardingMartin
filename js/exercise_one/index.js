//  Show form to add item
function showForm() {
  document.getElementById('form').classList.remove('d-none');
}

// Close form
function closeForm() {
  document.getElementById('form').classList.add('d-none');
}

// Function to add a new item on table
function addItem() {
  const description = document.getElementById('description').value;
  const cost = document.getElementById('cost').value;

  // Add a new row to the table
  const table = document.querySelector('table tbody');
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

  closeForm();
}

//  Show form to optimize according a budget
function showFormBudget() {
  document.getElementById('form-optimize').classList.remove('d-none');
}

// Close form to optimize
function closeFormOptimize() {
  document.getElementById('form-optimize').classList.add('d-none');
}

//  Optimize list
function optimize() {
  const budget = parseFloat(document.getElementById('budget').value);

  document.getElementById('title-budget').innerHTML = budget;

  //Optimize according to the budget
  if (isNaN(budget)) {
    // Do nothing
    return;
  }
  const table = document.getElementById("table");
  var switching, shouldSwitch, rows, i, x, y;

  switching = true;

  while (switching) {

    switching=false;
    rows=table.rows;

    for(i = 1; i < (rows.length - 1); i++){
      shouldSwitch = false;
      x = rows[i].cells[1];
      y = rows[i + 1].cells[1];
      if (parseFloat(x.textContent.substring(1)) > parseFloat(y.textContent.substring(1))) {
        shouldSwitch = true;
        break;
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }

  let remainingAmount = budget;
  var cost;
  for (const row of rows) {
    cost = parseFloat(row.cells[1].textContent.substring(1));
    if (!row.cells[2].checked && cost <= remainingAmount) {
      remainingAmount -= cost;
      console.log(row.cells[2].content.checked);
      row.geet = true;
      console.log(row.cells[2].checked);
    }
  }

  // Clean forms fields
  document.getElementById('budget').value = '';

  closeFormOptimize();
}
