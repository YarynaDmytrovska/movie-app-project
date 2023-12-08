using System.Collections.ObjectModel;
using System.Windows.Input;
using YourWpfProject.ViewModels.Commands;
using CinematicaBLL.Interfaces;
using CinematicaDAL.Models;

namespace YourWpfProject.ViewModels
{
    public class MainViewModel : ViewModelBase
    {
        private readonly IMovieGenreService _movieGenreService;
        private readonly IMovieListService _movieListService;
        private readonly IUserService _userService;

        public MainViewModel(IMovieGenreService movieGenreService, IMovieListService movieListService, IUserService userService)
        {
            _movieGenreService = movieGenreService;
            _movieListService = movieListService;
            _userService = userService;

            LoadData();
            InitializeCommands();
        }

        private void LoadData()
        {
            // Load genres, lists, and other initial data
            Genres = new ObservableCollection<MovieGenre>(_movieGenreService.GetAllGenres());
            Lists = new ObservableCollection<MovieList>(_movieListService.GetAllLists());
            Movies = new ObservableCollection<Movie>(_movieService.GetAllMovies());
            UserLists = new ObservableCollection<MovieList>(_userService.GetUserLists(  ));
        }

        #region Properties

        private ObservableCollection<MovieGenre> _genres;
        public ObservableCollection<MovieGenre> Genres
        {
            get => _genres;
            set
            {
                _genres = value;
                OnPropertyChanged(nameof(Genres));
            }
        }

        private ObservableCollection<MovieList> _lists;
        public ObservableCollection<MovieList> Lists
        {
            get => _lists;
            set
            {
                _lists = value;
                OnPropertyChanged(nameof(Lists));
            }
        }

        private ObservableCollection<Movie> _movies;
        public ObservableCollection<Movie> Movies
        {
            get => _movies;
            set
            {
                _movies = value;
                OnPropertyChanged(nameof(Movies));
            }
        }

        private ObservableCollection<MovieList> _userLists;
        public ObservableCollection<MovieList> UserLists
        {
            get => _userLists;
            set
            {
                _userLists = value;
                OnPropertyChanged(nameof(UserLists));
            }
        }

        private Movie _selectedMovie;
        public Movie SelectedMovie
        {
            get => _selectedMovie;
            set
            {
                _selectedMovie = value;
                OnPropertyChanged(nameof(SelectedMovie));
            }
        }

        #endregion

        #region Commands

        public ICommand ViewDetailsCommand { get; private set; }
        public ICommand AddToListCommand { get; private set; }
        public ICommand RemoveFromListCommand { get; private set; }

        private void InitializeCommands()
        {
            ViewDetailsCommand = new RelayCommand(ViewDetails);
            AddToListCommand = new RelayCommand(AddToList);
            RemoveFromListCommand = new RelayCommand(RemoveFromList);
        }


        private void ViewDetails(object parameter)
        {
            if (SelectedMovie != null)
            {
                MessageBox.Show($"Details for {SelectedMovie.Title}:\n\n{SelectedMovie.Description}");
            }
            else
            {
                MessageBox.Show("Please select a movie to view details.");
            }
        }

        private void AddToList(object parameter)
        {
            if (SelectedMovie != null)
            {
                var selectedList = /* Logic to get the selected list */;

                if (selectedList != null)
                {
                    // Check if the movie is not already in the list
                    if (!selectedList.Movies.Any(m => m.MovieId == SelectedMovie.MovieId))
                    {
                        _movieListService.AddMovieToList(selectedList.ListId, SelectedMovie.MovieId);
                        UserLists = new ObservableCollection<MovieList>(_userService.GetUserLists());
                        MessageBox.Show($"Added {SelectedMovie.Title} to {selectedList.ListName}");
                    }
                    else
                    {
                        MessageBox.Show($"{SelectedMovie.Title} is already in {selectedList.ListName}");
                    }
                }
                else
                {
                    MessageBox.Show("Please select a list to add the movie to.");
                }
            }
            else
            {
                MessageBox.Show("Please select a movie to add to the list.");
            }
        }

        private void RemoveFromList(object parameter)
        {
            if (SelectedMovie != null)
            {
                var selectedList = /* Logic to get the selected list */;

                if (selectedList != null)
                {
                    // Check if the movie is in the list
                    if (selectedList.Movies.Any(m => m.MovieId == SelectedMovie.MovieId))
                    {
                        _movieListService.RemoveMovieFromList(selectedList.ListId, SelectedMovie.MovieId);
                        UserLists = new ObservableCollection<MovieList>(_userService.GetUserLists());
                        MessageBox.Show($"Removed {SelectedMovie.Title} from {selectedList.ListName}");
                    }
                    else
                    {
                        MessageBox.Show($"{SelectedMovie.Title} is not in {selectedList.ListName}");
                    }
                }
                else
                {
                    MessageBox.Show("Please select a list to remove the movie from.");
                }
            }
            else
            {
                MessageBox.Show("Please select a movie to remove from the list.");
            }
        }
    }