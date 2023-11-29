using System;
using System.Data;
using System.Data.SqlClient;
using Npgsql;

namespace CinematicaConsoleApp
{
    class Program
    {
        static string connectionString = "Host=localhost;Port=5433;Database=cinematica;Username=postgres;Password=2005;";
        static Random random = new Random();

        static void Main(string[] args)
        {
            Console.WriteLine("Підключення до бази даних та робота з нею");

            using (NpgsqlConnection connection = new NpgsqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    Console.WriteLine("Підключення успішно встановлено.");

                    Console.WriteLine("\nДані з таблиці Users:");
                    DisplayUserData2(connection);

                    Console.WriteLine("\nЗаповнення таблиць тестовими даними...");
                    FillTablesWithTestData(connection);

                    Console.WriteLine("\nОновлені дані з таблиці Users:");
                    DisplayUserData2(connection);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Помилка: {ex.Message}");
                }
            }

            Console.WriteLine("\nНатисніть будь-яку клавішу для завершення...");
            Console.ReadKey();
        }

        private static void DisplayUserData2(NpgsqlConnection connection)
        {
            string query = "SELECT * FROM Users";

            using (NpgsqlCommand command = new NpgsqlCommand(query, connection))
            {
                using (NpgsqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Console.WriteLine($"UserID: {reader["UserID"]}, Email: {reader["Email"]}, Username: {reader["Username"]}");
                    }
                }
            }
        }

        private static void FillTablesWithTestData(NpgsqlConnection connection)
        {
            // Генерація тестових даних для таблиць
            for (int i = 0; i < 50; i++)
            {
                string email = GenerateUniqueRandomEmail(connection);
                string username = GenerateUniqueRandomUsername(connection);
                string password = GenerateRandomPassword();
                string avatar = GenerateRandomAvatar();
                string description = GenerateRandomDescription();

                int userId = GenerateRandomUserId();

                string insertQuery = $"INSERT INTO Users (UserID, Email, Username, Password, Avatar, Description) " +
                                     $"VALUES ({userId}, '{email}', '{username}', '{password}', '{avatar}', '{description}')";

                using (NpgsqlCommand command = new NpgsqlCommand(insertQuery, connection))
                {
                    command.ExecuteNonQuery();
                }
            }


            // Заповнюємо таблицю MovieGenres
            for (int i = 0; i < 50; i++)
            {
                string genreName = GenerateRandomGenreName();
                InsertGenre(connection, genreName);
            }

            // Заповнюємо таблицю Movies
            for (int i = 0; i < 50; i++)
            {
                string title = GenerateRandomMovieTitle();
                string poster = GenerateRandomMoviePoster();
                int releaseYear = GenerateRandomReleaseYear();
                string duration = GenerateRandomMovieDuration();
                string director = GenerateRandomDirector();
                string country = GenerateRandomCountry();
                string plot = GenerateRandomMoviePlot();

                InsertMovie(connection, title, poster, releaseYear, duration, director, country, plot);
            }

            string[] listStatuses = { "Watching", "Want to watch", "Wached" };

            for (int i = 0; i < 50; i++)
            {
                int randomIndex = random.Next(0, listStatuses.Length);
                string listStatus = listStatuses[randomIndex];

                InsertMovieList(connection, listStatus);
            }
        }

        private static string GenerateUniqueRandomUsername(NpgsqlConnection connection)
        {
            string username;
            do
            {
                username = GenerateRandomUsername();
            }
            while (UsernameExists(connection, username));

            return username;
        }

        private static bool UsernameExists(NpgsqlConnection connection, string username)
        {
            string query = $"SELECT COUNT(*) FROM Users WHERE Username = '{username}'";

            using (NpgsqlCommand command = new NpgsqlCommand(query, connection))
            {
                int count = Convert.ToInt32(command.ExecuteScalar());
                return count > 0;
            }
        }
        
        private static string GenerateUniqueRandomEmail(NpgsqlConnection connection)
        {
            string email;
            do
            {
                email = GenerateRandomEmail();
            }
            while (EmailExists(connection, email));

            return email;
        }

        private static bool EmailExists(NpgsqlConnection connection, string email)
        {
            string query = $"SELECT COUNT(*) FROM Users WHERE Email = '{email}'";

            using (NpgsqlCommand command = new NpgsqlCommand(query, connection))
            {
                int count = Convert.ToInt32(command.ExecuteScalar());
                return count > 0;
            }
        }

        private static string GenerateRandomEmail()
        {
            return $"user{random.Next(1000)}@example.com";
        }

        private static string GenerateRandomUsername()
        {
            return $"user{random.Next(1000)}";
        }

        private static string GenerateRandomPassword()
        {
            const string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            char[] password = new char[8];

            for (int i = 0; i < 8; i++)
            {
                password[i] = characters[random.Next(characters.Length)];
            }

            return new string(password);
        }

        private static string GenerateRandomAvatar()
        {
            return $"https://example.com/avatar{random.Next(10)}.jpg";
        }

        private static string GenerateRandomDescription()
        {
            string[] descriptions = {
                "Great user", "Movie lover", "Cinema enthusiast", "Film critic", "Casual viewer", "Entertainment seeker"
            };

            return descriptions[random.Next(descriptions.Length)];
        }

        private static string GenerateRandomGenreName()
        {
            string[] genres = { "Action", "Comedy", "Drama", "Horror", "Science Fiction", "Romance", "Adventure", "Fantasy", "Thriller" };
            return genres[random.Next(genres.Length)];
        }

        private static string GenerateRandomMovieTitle()
        {
            string[] titles = { "The Matrix", "Inception", "Avatar", "The Lord of the Rings", "Star Wars", "Titanic", "Jurassic Park", "The Dark Knight", "Forrest Gump" };
            return titles[random.Next(titles.Length)];
        }

        private static string GenerateRandomMoviePoster()
        {
            return $"https://example.com/poster{random.Next(10)}.jpg";
        }

        private static int GenerateRandomReleaseYear()
        {
            return random.Next(1900, 2023);
        }

        private static string GenerateRandomMovieDuration()
        {
            return $"{random.Next(60, 240)} min";
        }

        private static string GenerateRandomDirector()
        {
            string[] directors = { "Christopher Nolan", "James Cameron", "Peter Jackson", "Steven Spielberg", "George Lucas", "Quentin Tarantino", "Martin Scorsese", "Ridley Scott" };
            return directors[random.Next(directors.Length)];
        }

        private static string GenerateRandomCountry()
        {
            string[] countries = { "USA", "UK", "Canada", "Australia", "France", "Germany", "Japan", "China", "India" };
            return countries[random.Next(countries.Length)];
        }

        private static string GenerateRandomMoviePlot()
        {
            string[] plots = {
                "A computer hacker discovers a dystopian world.",
                "A thief who enters people's dreams to steal their secrets.",
                "A paraplegic marine becomes involved in the conflict on an alien planet.",
                "A hobbit sets out to destroy a powerful ring.",
                "A young Jedi knight fights against the dark side.",
                "A tragic love story aboard the Titanic.",
                "Dinosaurs escape from an island amusement park.",
                "Batman faces a new enemy in Gotham City.",
                "The life story of a man with a low IQ."
            };

            return plots[random.Next(plots.Length)];
        }

        static void InsertGenre(NpgsqlConnection connection, string genreName)
        {
            // Перевірка унікальності перед вставкою
            if (!GenreNameExists(connection, genreName))
            {
                string insertQuery = "INSERT INTO MovieGenres (GenreName) VALUES (@GenreName)";

                using (NpgsqlCommand command = new NpgsqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@GenreName", genreName);
                    command.ExecuteNonQuery();
                }
            }
            else
            {
                Console.WriteLine($"Жанр з ім'ям '{genreName}' вже існує.");
            }
        }

        static bool GenreNameExists(NpgsqlConnection connection, string genreName)
        {
            string query = $"SELECT COUNT(*) FROM MovieGenres WHERE GenreName = @GenreName";

            using (NpgsqlCommand command = new NpgsqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@GenreName", genreName);
                int count = Convert.ToInt32(command.ExecuteScalar());
                return count > 0;
            }
        }

        static void InsertMovie(NpgsqlConnection connection, string title, string poster, int releaseYear, string duration, string director, string country, string plot)
        {
            string insertQuery = "INSERT INTO Movies (Title, Poster, ReleaseYear, Duration, Director, Country, Plot) " +
                                 "VALUES (@Title, @Poster, @ReleaseYear, @Duration, @Director, @Country, @Plot)";

            using (NpgsqlCommand command = new NpgsqlCommand(insertQuery, connection))
            {
                command.Parameters.AddWithValue("@Title", title);
                command.Parameters.AddWithValue("@Poster", poster);
                command.Parameters.AddWithValue("@ReleaseYear", releaseYear);
                command.Parameters.AddWithValue("@Duration", duration);
                command.Parameters.AddWithValue("@Director", director);
                command.Parameters.AddWithValue("@Country", country);
                command.Parameters.AddWithValue("@Plot", plot);

                command.ExecuteNonQuery();
            }
        }

        static void InsertMovieList(NpgsqlConnection connection, string status)
        {
            string insertQuery = "INSERT INTO MovieLists (Status) VALUES (@Status)";

            using (NpgsqlCommand command = new NpgsqlCommand(insertQuery, connection))
            {
                command.Parameters.AddWithValue("@Status", status);
                command.ExecuteNonQuery();
            }
        }
        private static int GenerateUniqueRandomUserId(NpgsqlConnection connection)
        {
            int userId;
            do
            {
                userId = GenerateRandomUserId();
            }
            while (UserIdExists(connection, userId));

            return userId;
        }

        private static bool UserIdExists(NpgsqlConnection connection, int userId)
        {
            string query = $"SELECT COUNT(*) FROM Users WHERE UserID = {userId}";

            using (NpgsqlCommand command = new NpgsqlCommand(query, connection))
            {
                int count = Convert.ToInt32(command.ExecuteScalar());
                return count > 0;
            }
        }
        private static int GenerateRandomUserId()
        {
            // Генерація випадкового ID
            return random.Next(1000, 9999);
        }
    }


}
