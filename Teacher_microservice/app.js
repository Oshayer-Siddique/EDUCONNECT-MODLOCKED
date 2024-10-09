const express = require('express');
const mysql = require('mysql2');
const app = express();
const port = 3002;




// var con = mysql.createConnection({
//   host: "localhost",
//   user: "root",
//   password: "12345678"

// });

// con.connect(function(err) {
//   if (err) throw err;
//   console.log("Connected!");
// });

// Create a MySQL connection pool
const pool = mysql.createPool({
    host: 'localhost',    // Your MySQL host (usually 'localhost')
    user: 'root',         // Your MySQL username
    password: '12345678', // Your MySQL password
    database: 'sd_student' // Your MySQL database name
  });
  
  // Use promises for async/await with mysql2
  const promisePool = pool.promise();

  // Test the connection
promisePool.query('SELECT 1')
.then(() => {
  console.log('Connected to the database successfully!');
})
.catch(err => {
  console.error('Error connecting to the database:', err);
});
  
  // Home route
  app.get('/', (req, res) => {
    res.send('Hello, World!');
  });
  
  // Route to test MySQL connection
  app.get('/test-connection', async (req, res) => {
    try {
      const [result] = await promisePool.query('SELECT DATABASE()');
      res.send(`Connected to database: ${result[0]['DATABASE()']}`);
    } catch (err) {
      console.error('Connection error:', err);
      res.status(500).send('Error connecting to database');
    }
  });

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
