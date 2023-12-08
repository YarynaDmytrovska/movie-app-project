using CinematicaBLL.Services;
using CinematicaDAL.DbContext;
using Microsoft.EntityFrameworkCore;

using System.Windows;

namespace CinematicaUI
{
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            //  DbContextOptions відповідно до ваших потреб
            var options = new DbContextOptionsBuilder<CinematicaDbContext>()
                .UseNpgsql("Host=localhost;Port=5432;Database=Cinematica;Username=postgres;Password=zvkkk3bj;")
                .Options;

            // екземпляр CinematicaDbContext
            using (var dbContext = new CinematicaDbContext(options))
            {
                //  екземпляри сервісів
                var userService = new UserService(dbContext);
                var movieService = new MovieService(dbContext);

                //  вікно і передайте необхідні сервіси в конструктор
                var mainWindow = new MainWindow(userService, movieService);

                // Покажіть головне вікно
                mainWindow.Show();
            }
        }
    }
}