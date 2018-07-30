using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Zoolab.Models;

namespace Zoolab.Persistences.Repositories
{
    public interface IPubRepository
    {
        IEnumerable<Pub> GetPubsBy(int beerId);
        IEnumerable<Beer> GetBeersBy(int pubId);
    }
}
