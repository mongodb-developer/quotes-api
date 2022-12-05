import { MongoClient, ServerApiVersion } from 'mongodb';
import * as dotenv from 'dotenv';
import Express from 'express';

const app = Express();
dotenv.config();

const uri = process.env.MONGODB_CONNECTION_STRING;
const client = new MongoClient(uri, { serverApi: ServerApiVersion.v1 });
const DB = 'quotes_db';
const COLLECTION = 'quotes';

app.get('/random', async (request, response) => {
  try {
    const results = await client.db(DB).collection(COLLECTION).aggregate([
      { $sample: { size: 1 } }
    ]).toArray();
    response.send(results);
  } catch (error) {
    response.status(500).send({ message: error.message });
  }
});

app.get('/search', async (request, response) => {
  const searchQuery = request.query.q;
  try {
    const results = await client.db(DB).collection(COLLECTION).aggregate([
      {
        $search: {
          index: 'quotes-search-index',
          text: {
            query: searchQuery,
            path: ['Quote', 'Author'],
            fuzzy: {}
          }
        }
      },
      {
        $limit: 10
      },
      {
        $sort: {
          popularity: -1
        }
      }
    ]).toArray();
    response.send(results);
  } catch (error) {
    response.status(500).send({ message: error.message });
  }
});

app.listen(3000, async () => {
  try {
    await client.connect();
    console.log('Listening on port 3000');
  } catch (error) {
    console.error(error);
  }
});
