const { Sequelize } = require('sequelize');

// Create a new Sequelize instance for MySQL (adjust with your DB credentials)
const sequelize = new Sequelize(
  process.env.DB_NAME || 'movie_recommendation',  // DB name
  process.env.DB_USER || 'root',                // DB user
  process.env.DB_PASS || 'Sqlhead21%3',                    // DB password
  {
    host: process.env.DB_HOST || 'localhost',    // DB host
    port: process.env.DB_PORT || 3306,
    dialect: 'mysql',                            // DB dialect, adjust if using another DB
  }
);

// Test the database connection
sequelize.authenticate()
  .then(() => {
    console.log('Database connection has been established successfully.');
  })
  .catch((error) => {
    console.error('Unable to connect to the database:', error);
  });

module.exports = sequelize;
