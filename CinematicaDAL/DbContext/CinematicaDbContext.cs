using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql.EntityFrameworkCore.PostgreSQL;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using CinematicaDAL.Models;

public class CinematicaDbContext : DbContext
{
    public CinematicaDbContext(DbContextOptions<CinematicaDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users { get; set; }
    public DbSet<Movie> Movies { get; set; }
    public DbSet<MovieGenre> MovieGenres { get; set; }
    public DbSet<MovieList> MovieLists { get; set; }

    

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
      
        optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=Cinematica;Username=postgres;Password=zvkkk3bj;");
    }
}