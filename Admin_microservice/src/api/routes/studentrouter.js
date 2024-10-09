const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const Student = require('../models/studentmodel'); // Import the Student model


// Route to get all students
router.get('/all', studentController.getAllStudents);

// POST route to add a new student
router.post('/create', studentController.createStudent);



module.exports = router;