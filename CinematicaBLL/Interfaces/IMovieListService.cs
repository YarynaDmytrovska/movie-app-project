using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;
using CinematicaDAL.Models;

namespace CinematicaBLL.Interfaces

{
    public interface IMovieListService
    {
        List<MovieList> GetAllLists();
        void AddList(MovieList list);
        MovieList GetListById(int listId);
        void UpdateList(MovieList list);
        void DeleteList(int listId);

    }
}
