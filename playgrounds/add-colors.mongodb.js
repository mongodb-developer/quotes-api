/* global use, db, sleep */

const fetch = require('node-fetch');

/*
 *
 * This example uses the super cool Colormind API
 * http://colormind.io/api-access/
 *
 *     █████████           ████                                      ███                 █████
 *   ███░░░░░███         ░░███                                     ░░░                 ░░███
 *  ███     ░░░   ██████  ░███   ██████  ████████  █████████████   ████  ████████    ███████
 * ░███          ███░░███ ░███  ███░░███░░███░░███░░███░░███░░███ ░░███ ░░███░░███  ███░░███
 * ░███         ░███ ░███ ░███ ░███ ░███ ░███ ░░░  ░███ ░███ ░███  ░███  ░███ ░███ ░███ ░███
 * ░░███     ███░███ ░███ ░███ ░███ ░███ ░███      ░███ ░███ ░███  ░███  ░███ ░███ ░███ ░███
 *  ░░█████████ ░░██████  █████░░██████  █████     █████░███ █████ █████ ████ █████░░████████
 *   ░░░░░░░░░   ░░░░░░  ░░░░░  ░░░░░░  ░░░░░     ░░░░░ ░░░ ░░░░░ ░░░░░ ░░░░ ░░░░░  ░░░░░░░░
 *
 */

const COLORS_API_URL = 'http://colormind.io/api/';

use('quotes_db');
const quotes = db.quotes.find().limit(50).toArray().map(q => ({ _id: q._id }));

async function fetchInfo (quotes) {
  return Promise.all(quotes.map(async q => {
    try {
      sleep(Math.round(Math.random() * (2000 - 500) + 500));
      const response = await fetch(COLORS_API_URL, {
        method: 'post',
        body: JSON.stringify({ model: 'paper_mario' })
      });
      if (response.ok) {
        const data = await response.json();
        return { ...q, colors: data?.result };
      }
      console.log(response.status);
      return q;
    } catch (e) {
      console.log(e.message);
      return q;
    }
  }));
}

async function addSomeColor () {
  const quotesWithColors = await fetchInfo(quotes);
  for (const q of quotesWithColors) {
    db.quotes.updateOne({ _id: q._id }, { $set: { colors: q.colors } });
  }
}

addSomeColor();
