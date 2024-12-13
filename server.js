require('dotenv').config();
const express = require('express');
const session = require('express-session');
const axios = require('axios');
const path = require('path');
const sequelize = require('./config/database');
const User = require('./models/User');

const app = express();

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');

// Session setup
app.use(
  session({
    secret: 'my_development_secret', // Replace with a strong key
    resave: false,
    saveUninitialized: false,
    cookie: { secure: false }, // Secure should be true in production
  })
);

// Middleware to make 'user' available in all EJS templates
app.use((req, res, next) => {
  res.locals.user = req.session.user || null; // Assign user from session or set as null
  next();
});

// Database connection
sequelize
  .sync({ force: false })
  .then(() => console.log('Database connected'))
  .catch((err) => console.error('Database connection error:', err));

// Routes
const moviesRoutes = require('./routes/movies');
const authRoutes = require('./routes/auth');

app.use('/', moviesRoutes);
app.use('/', authRoutes);


// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
