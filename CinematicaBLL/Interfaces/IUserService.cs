using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CinematicaDAL.Models;
using System.Collections.Generic;

namespace CinematicaBLL.Interfaces
{
    public interface IUserService
    {
        List<User> GetAllUsers();
        void AddUser(User user);
        User GetUserById(int userId);
        void UpdateUser(User user);
        void DeleteUser(int userId);

        List<MovieList> GetUserLists(int userId);
        void AddMovieToList(int userId, int movieId, int listId);
        void RemoveMovieFromList(int userId, int movieId, int listId);
    }
}