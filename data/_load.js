// This script is for the MongoDB Shell
// mongosh <connection string> _load.js

const DB = 'quotes_db';
const COLLECTION = 'quotes';
const FILE_PATH = path.join(__dirname, 'quotes.json');

// Delete collection content
db.getSiblingDB(DB).getCollection(COLLECTION).deleteMany({});

console.log(`Reading and parsing ${FILE_PATH}`);
const quotes = EJSON.parse(fs.readFileSync(FILE_PATH));
console.log('Loading quotes into MongoDB');
db.getSiblingDB(DB).getCollection(COLLECTION).insertMany(quotes);
