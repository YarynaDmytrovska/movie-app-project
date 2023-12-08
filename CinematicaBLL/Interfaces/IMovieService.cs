using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CinematicaDAL.Models;

namespace CinematicaBLL.Interfaces
{
    public interface IMovieService
    {
        List<Movie> GetAllMovies();
        void AddMovie(Movie movie);
        Movie GetMovieById(int movieId);
        void UpdateMovie(Movie movie);
        void DeleteMovie(int movieId);


    }
}
