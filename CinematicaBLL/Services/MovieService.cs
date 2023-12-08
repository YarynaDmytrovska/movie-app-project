using System.Collections.Generic;
using CinematicaBLL.Interfaces;
using CinematicaDAL.Models;
using CinematicaDAL.Repositories;

namespace CinematicaBLL.Services
{
    public class MovieService : IMovieService
    {
        private readonly MovieRepository _movieRepository;

        public MovieService(MovieRepository movieRepository)
        {
            _movieRepository = movieRepository;
        }

        public List<Movie> GetAllMovies()
        {
            return _movieRepository.GetAllMovies();
        }

        public void AddMovie(Movie movie)
        {
            _movieRepository.AddMovie(movie);
        }

        public Movie GetMovieById(int movieId)
        {
            return _movieRepository.GetMovieById(movieId);
        }

        public void UpdateMovie(Movie movie)
        {
            _movieRepository.UpdateMovie(movie);
        }

        public void DeleteMovie(int movieId)
        {
            _movieRepository.DeleteMovie(movieId);
        }


    }
}