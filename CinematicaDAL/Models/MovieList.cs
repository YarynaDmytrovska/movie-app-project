using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CinematicaDAL.Models
{
    public class MovieList
    {
        public int ListID { get; set; }
        public string Status { get; set; }
        public int UserID { get; set; }

        public List<Movie> Movies { get; set; }
    }
}
