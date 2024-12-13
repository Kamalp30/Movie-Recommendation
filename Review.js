const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/database'); // Adjust path if necessary

const Review = sequelize.define('Review', {
  rating: {
    type: DataTypes.INTEGER,
    allowNull: false,
    validate: {
      min: 1,
      max: 10
    }
  },
  reviewText: {
    type: DataTypes.TEXT,  // Ensure this is defined
    allowNull: true
  },
  movieId: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false
  }
});

Review.associate = (models) => {
  Review.belongsTo(models.Movie, { foreignKey: 'movieId' });
  Review.belongsTo(models.User, { foreignKey: 'userId' });
};

module.exports = Review;
