using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CinematicaDAL.Models
{
    public class Movie
    {
        public int MovieID { get; set; }
        public string Title { get; set; }
        public string Poster { get; set; }
        public int ReleaseYear { get; set; }
        public string Duration { get; set; }
        public string Director { get; set; }
        public string Country { get; set; }
        public string Plot { get; set; }
    }
}
