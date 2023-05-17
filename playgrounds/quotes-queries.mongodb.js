/* global use, db */

// Get a random quote
use('quotes_db');
db.getCollection('quotes').aggregate([
  { $sample: { size: 1 } }
]);

// Full-text search query with Atlas Search
use('quotes_db');
const searchQuery = 'friends';
db.getCollection('quotes').aggregate([
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
]);

// Get all the tags
use('quotes_db');
db.getCollection('quotes').aggregate([
  {
    $unwind: {
      path: '$Tags'
    }
  },
  {
    $group: {
      _id: '$Tags',
      quotesWithThisTag: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      quotesWithThisTag: -1
    }
  }
]);