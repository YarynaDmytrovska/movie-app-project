using CinematicaDAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CinematicaDAL.Repositories
{
    public class MovieListRepository
    {

        private readonly CinematicaDbContext _dbContext;

        public MovieListRepository(CinematicaDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public List<MovieList> GetAllLists()
        {
            return _dbContext.MovieLists.ToList();
        }

        public void AddList(MovieList list)
        {
            _dbContext.MovieLists.Add(list);
            _dbContext.SaveChanges();
        }

        public MovieList GetListById(int listId)
        {
            return _dbContext.MovieLists.FirstOrDefault(l => l.ListID == listId);
        }

        public void UpdateList(MovieList list)
        {
            var existingList = _dbContext.MovieLists.FirstOrDefault(l => l.ListID == list.ListID);

            if (existingList != null)
            {
                existingList.Status = list.Status;

                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("List not found");
            }
        }

        public void DeleteList(int listId)
        {
            var list = _dbContext.MovieLists.FirstOrDefault(l => l.ListID == listId);

            if (list != null)
            {
                _dbContext.MovieLists.Remove(list);
                _dbContext.SaveChanges();
            }
            else
            {
                throw new InvalidOperationException("List not found");
            }
        }

    }
}

