using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Zoolab.Models;

namespace Zoolab.Persistences
{
    public class ZoolabDbContext : DbContext
    {
        public DbSet<Pub> Pubs { get; set; }
        public DbSet<Beer> Beers { get; set; }

        public ZoolabDbContext() : base("DefaultConnection")
        {
            
        }

        public static ZoolabDbContext Create()
        {
            return new ZoolabDbContext();
        }
    }
}