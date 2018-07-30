using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Zoolab.Models;

namespace Zoolab.Persistences.Repositories
{
    public class PubRepository : IPubRepository
    {
        private readonly ZoolabDbContext _context;

        public PubRepository(ZoolabDbContext context)
        {
            _context = context;
        }

        public IEnumerable<Pub> GetPubsBy(int beerId)
        {
            var beer = _context.Beers
                .Include(x => x.Pubs)
                .FirstOrDefault(x => x.Id == beerId);

            return beer?.Pubs.ToList() ?? new List<Pub>();
        }

        public IEnumerable<Beer> GetBeersBy(int pubId)
        {
            var pub = _context.Pubs
                .Include(x => x.Beers)
                .FirstOrDefault(x => x.Id == pubId);

            return pub?.Beers.ToList() ?? new List<Beer>();
        }
    }
}