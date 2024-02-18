const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const mysql = require('mysql');

const app = express();
const port = 3000;

// Create connection to MySQL database
const db = mysql.createConnection({
    host: '107.180.1.16',
    user: 'spring2024team6',
    password: 'spring2024team6',
    database: 'spring2024team6'
});

// Connect to database
db.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL database');
});

// Middleware to parse JSON bodies
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Endpoint to handle user signup
app.post('/signup', (req, res) => {
    const { username, password } = req.body;

    // Hash the password
    bcrypt.hash(password, 10, (err, hash) => {
        if (err) throw err;

        // Store the hashed password in the database
        const sql = 'INSERT INTO users (username, password) VALUES (?, ?)';
        db.query(sql, [username, hash], (err, result) => {
            if (err) {
                console.error('Error signing up:', err);
                return res.status(500).json({ message: 'Signup failed' });
            }
            console.log('User signed up successfully');
            res.status(200).json({ message: 'Signup successful' });
        });
    });
});

// Endpoint to handle user login
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Check if the username exists in the database
    const sql = 'SELECT * FROM users WHERE username = ?';
    db.query(sql, [username], (err, result) => {
        if (err) {
            console.error('Error logging in:', err);
            return res.status(500).json({ message: 'Login failed' });
        }
        if (result.length === 0) {
            return res.status(401).json({ message: 'Invalid username or password' });
        }

        // Compare the hashed password with the input password
        bcrypt.compare(password, result[0].password, (err, isValid) => {
            if (err || !isValid) {
                return res.status(401).json({ message: 'Invalid username or password' });
            }

            // Generate JWT token for authentication
            const token = jwt.sign({ username: result[0].username }, 'secretkey');
            res.status(200).json({ message: 'Login successful', token });
        });
    });
});

// Endpoint to handle survey submission
app.post('/submitSurvey', (req, res) => {
    // Extract survey data from request body
    const { username, surveyData } = req.body;

    // Store survey data in the database
    const sql = 'INSERT INTO survey_responses (username, survey_data) VALUES (?, ?)';
    db.query(sql, [username, surveyData], (err, result) => {
        if (err) {
            console.error('Error submitting survey:', err);
            return res.status(500).json({ message: 'Survey submission failed' });
        }
        console.log('Survey submitted successfully');
        res.status(200).json({ message: 'Survey submitted successfully' });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${3306}`);
});
