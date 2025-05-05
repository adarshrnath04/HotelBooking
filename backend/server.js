const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const db = require('./db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// User Signup API
app.post('/api/signup', async (req, res) => {
  const { full_name, email, password } = req.body;
  
  const hashedPassword = await bcrypt.hash(password, 10);
  
  db.query('INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)', 
  [full_name, email, hashedPassword], 
  (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Error signing up user.' });
    }
    res.status(201).json({ message: 'User created successfully' });
  });
});

// User Login API
app.post('/api/login', (req, res) => {
  const { email, password } = req.body;
  
  db.query('SELECT * FROM users WHERE email = ?', [email], async (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Error logging in user.' });
    }
    
    if (result.length === 0 || !(await bcrypt.compare(password, result[0].password))) {
      return res.status(400).json({ message: 'Invalid email or password' });
    }
    
    const token = jwt.sign({ id: result[0].id, email: result[0].email }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.json({ token, full_name: result[0].full_name });
  });
});

// Fetch Hotels API
app.get('/api/hotels', (req, res) => {
  db.query('SELECT * FROM hotels', (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Error fetching hotels' });
    }
    res.json(result);
  });
});

// Fetch Single Hotel Details API
// Fetch Single Hotel Details API
// Get single hotel details

app.get('/api/hotel/:hotel_id', (req, res) => {
    const { hotel_id } = req.params;
    db.query('SELECT * FROM hotels WHERE hotel_id = ?', [hotel_id], (err, result) => {
      if (err) {
        return res.status(500).json({ message: 'Error fetching hotel details' });
      }
      res.json(result[0]);
    });
  });
  
  app.get('/api/hotel/:hotel_id/rooms', (req, res) => {
    const { hotel_id } = req.params;
    db.query('SELECT * FROM rooms WHERE hotel_id = ? AND availability = TRUE', [hotel_id], (err, result) => {
      if (err) {
        return res.status(500).json({ message: 'Error fetching room details' });
      }
      res.json(result);
    });
  });
  

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
