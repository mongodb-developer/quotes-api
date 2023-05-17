/* global use, db */

const child_process = require('child_process');
const path = require('path');
const fs = require('fs');


const DB = 'quotes_db';
const COLLECTION = 'quotes';
const FILE_PATH = path.join('data', 'quotes.json');

child_process.execSync(`unzip -o ${path.join('data', 'quotes.zip')} -d data`);

// Delete collection content
db.getSiblingDB(DB).getCollection(COLLECTION).deleteMany({});

console.log(`Reading and parsing ${FILE_PATH}`);
const quotes = EJSON.parse(fs.readFileSync(FILE_PATH));
console.log('Loading quotes into MongoDB');
db.getSiblingDB(DB).getCollection(COLLECTION).insertMany(quotes);
`Inserted ${db.getSiblingDB(DB).getCollection(COLLECTION).estimatedDocumentCount()} quotes`;
