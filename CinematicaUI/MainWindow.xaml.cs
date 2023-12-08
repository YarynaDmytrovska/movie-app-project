using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using CinematicaBLL.Services;
using System.Collections.ObjectModel;
using CinematicaDAL.Models;


namespace CinematicaUI
{
    public partial class MainWindow : Window
    {
        private readonly UserService _userService;
        private readonly MovieService _movieService;

        public ObservableCollection<User> Users { get; set; }

        public MainWindow(UserService userService, MovieService movieService)
        {

            _userService = userService;
            _movieService = movieService;

            Users = new ObservableCollection<User>(_userService.GetAllUsers());

            // Інші налаштування вашого вікна...
            DataContext = this;
        }

        // Інші обробники подій, методи і т.д.
    }
}