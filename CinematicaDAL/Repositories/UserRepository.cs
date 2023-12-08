using CinematicaDAL.Models;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace CinematicaDAL.Repositories
{
    public class UserRepository
    {
        private readonly CinematicaDbContext _dbContext;

        public UserRepository(CinematicaDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public List<User> GetAllUsers()
        {
            return _dbContext.Users.ToList();
        }

        public void AddUser(User user)
        {
            _dbContext.Users.Add(user);
            _dbContext.SaveChanges();
        }

        public User GetUserById(int userId)
        {
            return _dbContext.Users.FirstOrDefault(u => u.UserID == userId);
        }

        public void UpdateUser(User user)
        {
            var existingUser = _dbContext.Users.FirstOrDefault(u => u.UserID == user.UserID);

            if (existingUser != null)
            {
                existingUser.Email = user.Email;
                existingUser.Username = user.Username;
                existingUser.Password = user.Password;
                existingUser.Avatar = user.Avatar;
                existingUser.Description = user.Description;

                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("User not found");
            }
        }

        public void DeleteUser(int userId)
        {
            var user = _dbContext.Users.FirstOrDefault(u => u.UserID == userId);

            if (user != null)
            {
                _dbContext.Users.Remove(user);
                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("User not found");
            }
        }

        public List<MovieList> GetUserLists(int userId)
        {
            return _dbContext.MovieLists
                .Where(ml => ml.UserID == userId)
                .Include(ml => ml.Movies)
                .ToList();
        }

        public void AddMovieToList(int userId, int movieId, int listId)
        {
            var user = _dbContext.Users.FirstOrDefault(u => u.UserID == userId);
            var movie = _dbContext.Movies.FirstOrDefault(m => m.MovieID == movieId);
            var list = _dbContext.MovieLists.FirstOrDefault(ml => ml.ListID == listId && ml.UserID == userId);

            if (user != null && movie != null && list != null)
            {
                list.Movies.Add(movie);
                _dbContext.SaveChanges();
            }
        }

        public void RemoveMovieFromList(int userId, int movieId, int listId)
        {
            var list = _dbContext.MovieLists.FirstOrDefault(ml => ml.ListID == listId && ml.UserID == userId);
            var movie = _dbContext.Movies.FirstOrDefault(m => m.MovieID == movieId);

            if (list != null && movie != null)
            {
                list.Movies.Remove(movie);
                _dbContext.SaveChanges();
            }
        }

    }
}