"use strict";

const table_data = [ { first_name : 'Rose',
last_name  : 'Tyler',
home       : 'Earth' },
{ first_name : 'Zoe',
last_name  : 'Heriot',
home       : 'Space Station W3'},
{ first_name : 'Jo',
last_name  : 'Grant',
home       : 'Earth'},
{ first_name : 'Leela',
last_name  : null,
home       : 'Unspecified'},
{ first_name : 'Romana',
last_name  : null,
home       : 'Gallifrey'},
{ first_name : 'Clara',
last_name  : 'Oswald',
home       : 'Earth'},
{ first_name : 'Adric',
last_name  : null,
home       : 'Alzarius'},
{ first_name : 'Susan',
last_name  : 'Foreman',
home       : 'Gallifrey'} ];

const tableDataContainers = document.getElementsByClassName('table-data-container');

// Append tbody rows to every element of selected class
for(var i = 0; i < tableDataContainers.length; i++) {
  for(var x = 0; x < table_data.length; x++) {  
    let newRow = `<tr><td>${table_data[x].first_name}</td>
                  <td>${table_data[x].last_name}</td>
                  <td>${table_data[x].home}</td></tr>`;

    tableDataContainers[i].getElementsByTagName('tbody')[0].innerHTML += newRow;
  }
}
