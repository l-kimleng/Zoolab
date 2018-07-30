using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Zoolab.Models
{
    public class Beer
    {
        public int Id { get; set; }

        [Required]
        [StringLength(255)]
        public string Brand { get; set; }

        public float Abv { get; set; }

        public ICollection<Pub> Pubs { get; set; }

        public Beer()
        {
            Pubs = new Collection<Pub>();
        }
    }
}