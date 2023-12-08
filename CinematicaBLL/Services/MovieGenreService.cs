using System.Collections.Generic;
using CinematicaBLL.Interfaces;
using CinematicaDAL.Models;
using CinematicaDAL.Repositories;

namespace CinematicaBLL.Services
{
    public class MovieGenreService : IMovieGenreService
    {
        private readonly MovieGenreRepository _genreRepository;

        public MovieGenreService(MovieGenreRepository genreRepository)
        {
            _genreRepository = genreRepository;
        }

        public List<MovieGenre> GetAllGenres()
        {
            return _genreRepository.GetAllGenres();
        }

        public void AddGenre(MovieGenre genre)
        {
            _genreRepository.AddGenre(genre);
        }

        public MovieGenre GetGenreById(int genreId)
        {
            return _genreRepository.GetGenreById(genreId);
        }

        public void UpdateGenre(MovieGenre genre)
        {
            _genreRepository.UpdateGenre(genre);
        }

        public void DeleteGenre(int genreId)
        {
            _genreRepository.DeleteGenre(genreId);
        }

    }
}