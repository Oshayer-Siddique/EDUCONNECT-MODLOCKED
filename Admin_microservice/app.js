const express = require("express");
const mysql = require("mysql2");
const bodyParser = require("body-parser");
const sequelize = require("./src/api/config/dbconfig");
const app = express();
const port = 3003;

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
// const pool = mysql.createPool({
//     host: 'localhost',    // Your MySQL host (usually 'localhost')
//     user: 'root',         // Your MySQL username
//     password: '12345678', // Your MySQL password
//     database: 'EDUCONNECT' // Your MySQL database name
//   });

//   // Use promises for async/await with mysql2
//   const promisePool = pool.promise();

//   // Test the connection
// promisePool.query('SELECT 1')
// .then(() => {
//   console.log('Connected to the database successfully!');
// })
// .catch(err => {
//   console.error('Error connecting to the database:', err);
// });

// Home route

app.use(bodyParser.json());

// Sync all models to the database
// Sync Sequelize models with the database
sequelize.sync({ alter: true }) // `alter: true` ensures that the table is created/updated without losing data
  .then(() => {
    console.log('Database synced, and tables created/updated!');
  })
  .catch(error => {
    console.error('Error syncing database:', error);
  });

const studentRoutes = require("./src/api/routes/studentrouter");

app.get("/", (req, res) => {
  res.send("Hello, Admin!");
});

// Use the student routes, with a base path of '/student'
app.use("/student", studentRoutes);



// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
