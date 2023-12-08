using System.Collections.Generic;
using CinematicaBLL.Interfaces;
using CinematicaDAL.Models;
using CinematicaDAL.Repositories;

namespace CinematicaBLL.Services
{
    public class MovieListService : IMovieListService
    {
        private readonly MovieListRepository _listRepository;

        public MovieListService(MovieListRepository listRepository)
        {
            _listRepository = listRepository;
        }

        public List<MovieList> GetAllLists()
        {
            return _listRepository.GetAllLists();
        }

        public void AddList(MovieList list)
        {
            _listRepository.AddList(list);
        }

        public MovieList GetListById(int listId)
        {
            return _listRepository.GetListById(listId);
        }

        public void UpdateList(MovieList list)
        {
            _listRepository.UpdateList(list);
        }

        public void DeleteList(int listId)
        {
            _listRepository.DeleteList(listId);
        }
    }
}