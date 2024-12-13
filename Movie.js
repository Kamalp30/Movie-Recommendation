const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Movie = sequelize.define('Movie', {
  title: { type: DataTypes.STRING, allowNull: false },
  genre: { type: DataTypes.STRING },
  rating: { type: DataTypes.FLOAT },
});

module.exports = Movie;
