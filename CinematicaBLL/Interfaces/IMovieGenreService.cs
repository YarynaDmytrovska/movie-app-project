using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;
using CinematicaDAL.Models;

namespace CinematicaBLL.Interfaces
{
    public interface IMovieGenreService
    {
        List<MovieGenre> GetAllGenres();
        void AddGenre(MovieGenre genre);
        MovieGenre GetGenreById(int genreId);
        void UpdateGenre(MovieGenre genre);
        void DeleteGenre(int genreId);


    }
}
