const Student = require('../models/studentmodel');



exports.getAllStudents = async (req, res) => {
    try {
      const students = await Student.findAll();
      res.json(students);
    } catch (error) {
      res.status(500).json({ error: 'An error occurred while fetching students.' });
    }
  };
  
  // Create a new student
  exports.createStudent = async (req, res) => {
    const { name, email, dateOfBirth, enrollmentDate } = req.body; // 1. Extract student data
  
    try {
      // 2. Create and insert a new student into the database using Sequelize
      const newStudent = await Student.create({
        name,
        email,
        dateOfBirth,
        enrollmentDate,
      });
  
      // 3. Respond with the newly created student data
      res.status(201).json(newStudent);
    } catch (error) {
      // 4. Error handling: Log the error and send a 500 response with error message
      console.error('Error inserting student:', error);
      res.status(500).json({ error: 'Failed to insert student' });
    }
  };