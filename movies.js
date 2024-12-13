const express = require('express');
const axios = require('axios');
const router = express.Router();
const TMDB_API_KEY = process.env.TMDB_API_KEY;
const Review = require('../models/Review');
const User = require('../models/User');
const Movie = require('../models/movie');

router.get('/about', (req, res) => {
  res.render('about');  // Render the About page
});

// Trending Movies
router.get('/', async (req, res) => {
  try {
    // Fetch trending movies from TMDB
    const response = await axios.get(
      `https://api.themoviedb.org/3/trending/movie/day?api_key=${TMDB_API_KEY}`
    );
    const movies = response.data.results;

    // Fetch reviews for each movie to calculate average ratings
    const moviesWithRatings = await Promise.all(movies.map(async (movie) => {
      const reviews = await Review.findAll({ where: { movieId: movie.id } });

      // Calculate average rating for the movie
      let averageRating = 0;
      if (reviews.length > 0) {
        const totalRatings = reviews.reduce((sum, review) => sum + review.rating, 0);
        averageRating = totalRatings / reviews.length;
      }

      // Return the movie with its average rating
      return {
        ...movie,
        averageRating: averageRating.toFixed(1) // Format the rating to 1 decimal place
      };
    }));

    // Render the home page with the movies and their ratings
    res.render('index', { movies: moviesWithRatings, user: req.session.user });
  } catch (error) {
    console.error('Error fetching movies:', error);
    res.status(500).send('Server Error');
  }
});

// Search for movies by title, genre, or actor
router.get('/search', async (req, res) => {
  const { query, type } = req.query; // Get query and type from the request
  let apiUrl = '';

  try {
    // Ensure both query and type are provided
    if (!query || !type) {
      return res.render('search', { movies: [], error: 'Please provide a search query and type.', query });
    }

    // Construct the TMDB API URL based on the search type
    if (type === 'title') {
      apiUrl = `https://api.themoviedb.org/3/search/movie?api_key=${TMDB_API_KEY}&query=${query}`;
    } else if (type === 'genre') {
      const genresResponse = await axios.get(`https://api.themoviedb.org/3/genre/movie/list?api_key=${TMDB_API_KEY}`);
      const genres = genresResponse.data.genres;
      const genre = genres.find((g) => g.name.toLowerCase() === query.toLowerCase());
      if (genre) {
        apiUrl = `https://api.themoviedb.org/3/discover/movie?api_key=${TMDB_API_KEY}&with_genres=${genre.id}`;
      } else {
        return res.render('search', { movies: [], error: 'Genre not found.', query });
      }
    } else if (type === 'actor') {
      const peopleResponse = await axios.get(`https://api.themoviedb.org/3/search/person?api_key=${TMDB_API_KEY}&query=${query}`);
      if (peopleResponse.data.results.length > 0) {
        const actorId = peopleResponse.data.results[0].id;
        apiUrl = `https://api.themoviedb.org/3/discover/movie?api_key=${TMDB_API_KEY}&with_cast=${actorId}`;
      } else {
        return res.render('search', { movies: [], error: 'Actor not found.', query });
      }
    } else {
      return res.render('search', { movies: [], error: 'Invalid search type.', query });
    }

    // Fetch movies from TMDB
    const response = await axios.get(apiUrl);
    const movies = response.data.results;

    // Loop through the movies and check if they exist in the database
    const updatedMovies = await Promise.all(
      movies.map(async (movie) => {
        const existingMovie = await Movie.findOne({ where: { title: movie.title } });

        if (existingMovie) {
          // If the movie is in the database, use the rating from the database
          movie.rating = existingMovie.rating;
        } else {
          // If the movie is not in the database, add it with the TMDB rating
          await Movie.create({
            title: movie.title,
            genre: movie.genre_ids[0], // Assuming only one genre, adjust if necessary
            rating: movie.vote_average,
          });
          movie.rating = movie.vote_average;
        }

        return movie;
      })
    );

    // Render the search results with the movie data including ratings
    res.render('search', { movies: updatedMovies, error: null, query });
  } catch (error) {
    console.error('Error searching movies:', error);
    res.status(500).render('search', { movies: [], error: 'An error occurred while processing your request.', query });
  }
});


// Movie Details
router.get('/movie/:id', async (req, res) => {
  const movieId = req.params.id;

  try {
    const response = await axios.get(
      `https://api.themoviedb.org/3/movie/${movieId}?api_key=${TMDB_API_KEY}`
    );
    const movie = response.data;

    const reviews = await Review.findAll({ where: { movieId } });

    const reviewsWithUsernames = await Promise.all(
      reviews.map(async (review) => {
        const user = await User.findByPk(review.userId);
        return {
          ...review.toJSON(),
          userName: user ? user.username : 'Anonymous',
        };
      })
    );

    let averageRating = 0;
    if (reviews.length > 0) {
      const totalRatings = reviews.reduce((sum, review) => sum + review.rating, 0);
      averageRating = totalRatings / reviews.length;
    }

    res.render('movieDetails', {
      movie,
      reviews: reviewsWithUsernames,
      user: req.session.user,
      averageRating: averageRating || 0 // Ensure a default value is sent
    });
  } catch (error) {
    console.error('Error fetching movie details or reviews:', error);
    res.status(500).send('Server Error');
  }
});

// Rate Movie
router.post('/movie/:id/rate', async (req, res) => {
  const movieId = req.params.id;
  const { rating, reviewText } = req.body;
  const userId = req.session.user.id;

  try {
    // Save the rating and review in the database
    await Review.create({
      movieId,
      userId,
      rating,
      reviewText
    });

    res.redirect(`/movie/${movieId}`); // Redirect back to the movie details page
  } catch (error) {
    console.error('Error saving review:', error);
    res.status(500).send('Server Error');
  }
});


module.exports = router;
