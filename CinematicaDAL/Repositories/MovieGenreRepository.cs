
using CinematicaDAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CinematicaDAL.Repositories
{
    public class MovieGenreRepository
    {
        
            private readonly CinematicaDbContext _dbContext;

            public MovieGenreRepository(CinematicaDbContext dbContext)
            {
                _dbContext = dbContext;
            }

            public List<MovieGenre> GetAllGenres()
            {
                return _dbContext.MovieGenres.ToList();
            }

            public void AddGenre(MovieGenre genre)
            {
                _dbContext.MovieGenres.Add(genre);
                _dbContext.SaveChanges();
            }

            public MovieGenre GetGenreById(int genreId)
            {
                return _dbContext.MovieGenres.FirstOrDefault(g => g.GenreID == genreId);
            }

            public void UpdateGenre(MovieGenre genre)
            {
                var existingGenre = _dbContext.MovieGenres.FirstOrDefault(g => g.GenreID == genre.GenreID);

                if (existingGenre != null)
                {
                    existingGenre.GenreName = genre.GenreName;

                    _dbContext.SaveChanges();
                }
                else
                {
                    throw new InvalidOperationException("Genre not found");
                }
            }

            public void DeleteGenre(int genreId)
            {
                var genre = _dbContext.MovieGenres.FirstOrDefault(g => g.GenreID == genreId);

                if (genre != null)
                {
                    _dbContext.MovieGenres.Remove(genre);
                    _dbContext.SaveChanges();
                }
                else
                {
                    throw new InvalidOperationException("Genre not found");
                }
            }


        }
    }

