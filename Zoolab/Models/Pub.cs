using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Zoolab.Models
{
    public class Pub
    {
        public int Id { get; set; }

        [Required]
        [StringLength(255)]
        public string Name { get; set; }

        [StringLength(255)]
        public string Location { get; set; }

        public float Rate { get; set; }

        public ICollection<Beer> Beers { get; set; }

        public Pub()
        {
            Beers = new Collection<Beer>();
        }
    }
}