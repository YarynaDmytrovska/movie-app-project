
using CinematicaDAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CinematicaDAL.Repositories
{
    public class MovieRepository
    {
        private readonly CinematicaDbContext _dbContext;

        public MovieRepository(CinematicaDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public List<Movie> GetAllMovies()
        {
            return _dbContext.Movies.ToList();
        }

        public void AddMovie(Movie movie)
        {
            _dbContext.Movies.Add(movie);
            _dbContext.SaveChanges();
        }

        public Movie GetMovieById(int movieId)
        {
            return _dbContext.Movies.FirstOrDefault(m => m.MovieID == movieId);
        }

        public void UpdateMovie(Movie movie)
        {
            var existingMovie = _dbContext.Movies.FirstOrDefault(m => m.MovieID == movie.MovieID);

            if (existingMovie != null)
            {
                existingMovie.Title = movie.Title;
                existingMovie.Poster = movie.Poster;
                existingMovie.ReleaseYear = movie.ReleaseYear;
                existingMovie.Duration = movie.Duration;
                existingMovie.Director = movie.Director;
                existingMovie.Country = movie.Country;
                existingMovie.Plot = movie.Plot;

                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("Movie not found");
            }
        }

        public void DeleteMovie(int movieId)
        {
            var movie = _dbContext.Movies.FirstOrDefault(m => m.MovieID == movieId);

            if (movie != null)
            {
                _dbContext.Movies.Remove(movie);
                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("Movie not found");
            }
        }


    }
}

