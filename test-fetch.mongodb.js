/* global use, db */
const fetch = require('node-fetch');

async function go() {
  const response = await fetch('https://api.github.com/users/github');
  const data = await response.json();
  return data;
}

go();