using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Zoolab.Persistences;
using Zoolab.Persistences.Repositories;

namespace Zoolab.Controllers
{
    [System.Web.Http.RoutePrefix("api/pubs")]
    public class PubsController : ApiController
    {
        private readonly ZoolabDbContext _context;

        public PubsController()
        {
            _context = ZoolabDbContext.Create();
        }

        private IPubRepository _pubRepository;

        public IPubRepository PubRepository
        {
            get
            {
                if (_pubRepository == null)
                {
                    return _pubRepository = new PubRepository(_context);
                }
                return _pubRepository;
            }
        }

        protected override void Dispose(bool disposing)
        {
            _context.Dispose();
            base.Dispose(disposing);
        }


        // GET api/pubs/pub/{beerId}
        [Route("pub/{beerId}")]
        public IHttpActionResult GetPub(int beerId)
        {
            var pubs = PubRepository.GetPubsBy(beerId);
            var result = pubs.Select(x => x.Id).ToArray();

            if (result.Length == 0)
            {
                return NotFound();
            }

            return Ok(new { total = result.Length, data = result });
        }

        // GET api/pubs/beer/{pubId}
        [Route("beer/{pubId}")]
        public IHttpActionResult GetBeer(int pubId)
        {
            var beers = PubRepository.GetBeersBy(pubId);
            var result = beers.Select(x => x.Id).ToArray();

            if (result.Length == 0)
            {
                return NotFound();
            }

            return Ok(new { total = result.Length, data = result });
        }
    }
}
