/* global use, db */

const fetch = require('node-fetch');

const URL = author => `https://en.wikipedia.org/api/rest_v1/page/summary/${encodeURIComponent(author)}`;

use('quotes_db');
const allTheQuotes = db.quotes.find().limit(10).toArray().map(q => ({ _id: q._id, Author: q.Author }));

async function sleep(howLong = Math.round(Math.random() * (5000 - 1000) + 1000)) {
  console.log('sleeping', howLong);
  return new Promise(resolve => setTimeout(resolve, howLong));
}

async function fetchInfo(quotes) {
  return Promise.all(quotes.map(async q => {
    try {
      await sleep();
      const response = await fetch(URL(q.Author));
      if(response.ok) {
        const data = await response.json();
        return {...q, image: data?.originalimage?.source, authorDescription: data?.description}
      }
      console.log(response.status);
      return q;  
    }
    catch (e) {
      console.log(URL(q.Author), e.message);
      return q;
    }
  }));
}

console.log(fetchInfo(allTheQuotes));