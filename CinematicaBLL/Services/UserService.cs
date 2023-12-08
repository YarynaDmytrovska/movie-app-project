using CinematicaBLL.Interfaces;
using CinematicaDAL.Models;
using CinematicaDAL.Repositories;
using System.Collections.Generic;

namespace CinematicaBLL.Services
{
    public class UserService : IUserService
    {
        private readonly UserRepository _userRepository;

        public UserService(UserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public List<User> GetAllUsers()
        {
            return _userRepository.GetAllUsers();
        }

        public void AddUser(User user)
        {
            _userRepository.AddUser(user);
        }

        public User GetUserById(int userId)
        {
            return _userRepository.GetUserById(userId);
        }

        public void UpdateUser(User user)
        {
            _userRepository.UpdateUser(user);
        }

        public void DeleteUser(int userId)
        {
            _userRepository.DeleteUser(userId);
        }

        // Implementation of IUserService methods
        public List<MovieList> GetUserLists(int userId)
        {
            return _userRepository.GetUserLists(userId);
        }

        public void AddMovieToList(int userId, int movieId, int listId)
        {
            _userRepository.AddMovieToList(userId, movieId, listId);
        }

        public void RemoveMovieFromList(int userId, int movieId, int listId)
        {
            _userRepository.RemoveMovieFromList(userId, movieId, listId);
        }
    }
}