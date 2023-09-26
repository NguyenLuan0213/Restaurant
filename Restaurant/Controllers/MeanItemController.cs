using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.DTO;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class MeanItemController : ControllerBase
    {
        private readonly IMeanItemRepository _meanItemRepository;
        private readonly IMapper _mapper;

        public  MeanItemController(IMeanItemRepository meanItemRepository, IMapper mapper)
        {
            _meanItemRepository = meanItemRepository;
            _mapper = mapper;
        }

        // GET: api/MeanItem
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Meanitem>))]
        public IActionResult GetMeanItems()
        {
            var meanItem = _mapper.Map<List<MeanItemDTO>>(_meanItemRepository.GetMeanIteams());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(meanItem);
        }

        // GET: api/MeanItem/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Meanitem))]
        [ProducesResponseType(400)]
        public IActionResult GetMenuItemById(int id)
        {
            if (!_meanItemRepository.MeanIteamExists(id))
            {
                return NotFound();
            }
            var meanItem = _mapper.Map<MeanItemDTO>(_meanItemRepository.GetMeanIteamById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(meanItem);
        }

        // GET: api/MeanItem/meanId
        [HttpGet("mean/{meanId}")]
        [ProducesResponseType(200, Type = typeof(Meanitem))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetMeanItemByMeanId(int meanId)
        {
            if (!_meanItemRepository.MeanIteamExists(meanId))
            {
                return NotFound();
            }
            var meanItem = _meanItemRepository.GetMeanIteamByMeanId(meanId);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (meanItem == null || !meanItem.Any())
            {
                return NotFound();
            }
            var meanItemDto = _mapper.Map<List<MeanItemDTO>>(meanItem);
            return Ok(meanItemDto);
        }

        // Post api/MeanItem
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(MeanItemDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateMeanIteam([FromBody] MeanItemDTO meanItemDTO)
        {
            if (meanItemDTO == null)
            {
                return BadRequest("Invalid data");
            }
            
            var meanItem = new Meanitem()
            {
                MeanId = meanItemDTO.MeanId,
                MenuItemId = meanItemDTO.MenuItemId,
                Quantity = meanItemDTO.Quantity
            };
            _mapper.Map<Meanitem>(meanItemDTO);

            if(!_meanItemRepository.CreateMeanIteam(meanItem))
            {
                return BadRequest("Unable to create mean item");
            };
            
            var createdMeanItemDTO = _mapper.Map<MeanItemDTO>(meanItem);

            return CreatedAtAction(nameof(GetMenuItemById), new { id = createdMeanItemDTO.Id }, createdMeanItemDTO);
        }

        // PUT api/MeanItem/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateMeanItem(int id, [FromBody] MeanItemDTO meanItemDTO)
        {
            if (meanItemDTO == null || id != meanItemDTO.Id)
            {
                return BadRequest("Invalid data");
            }
            if (!_meanItemRepository.MeanIteamExists(id))
            {
                return NotFound();
            }
            var meanItem = new Meanitem()
            {
                Id = meanItemDTO.Id,
                MeanId = meanItemDTO.MeanId,
                MenuItemId = meanItemDTO.MenuItemId,
                Quantity = meanItemDTO.Quantity
            };
            _mapper.Map<Meanitem>(meanItemDTO);
            if (!_meanItemRepository.UpdateMeanIteam(meanItem))
            {
                return BadRequest("Unable to update mean item");
            };
            return NoContent();
        }

        // DELETE api/MeanItem/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteMeanItem(int id)
        {
            if (!_meanItemRepository.MeanIteamExists(id))
            {
                return NotFound();
            }

            if (!_meanItemRepository.DeleteMeanIteam(id))
            {
                return BadRequest("Unable to delete mean item");
            };
            return NoContent();
        }
    }
}
