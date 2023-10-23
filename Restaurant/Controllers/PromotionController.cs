using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class PromotionController : ControllerBase
    {
        private readonly IPromotionsRepository _promotionsRepository;
        private readonly IMapper _mapper;

        public PromotionController(IPromotionsRepository promotionsRepository, IMapper mapper)
        {
            _promotionsRepository = promotionsRepository;
            _mapper = mapper;
        }

        // GET: api/Promotion
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Promotion>))]
        public IActionResult GetPromotions()
        {
            var promotion = _mapper.Map<List<PromotionsDTO>>(_promotionsRepository.GetPromotions());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(promotion);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Promotion))]
        [ProducesResponseType(400)]
        public IActionResult GetPromotionId(int id)
        {
            if (!_promotionsRepository.PromotionExists(id))
            {
                return NotFound();
            }

            var promotions = _mapper.Map<PromotionsDTO>(_promotionsRepository.GetPromotionId(id));

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            return Ok(promotions);
        }


        [HttpGet("restaurant/{id}")]
        [ProducesResponseType(200, Type = typeof(Promotion))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetPromotionsByRestaurantId(int id)
        {
            if (!_promotionsRepository.PromotionExists(id))
            {
                return NotFound();
            }

            var promotions = _promotionsRepository.GetPromotionByRestaurantId(id);

            if (promotions == null)
            {
                return NotFound();
            }

            var promotionsDTO = _mapper.Map<ICollection<PromotionsDTO>>(promotions);


            return Ok(promotionsDTO);
        }

        // POST: api/Promotion
        [HttpPost]
        public IActionResult CreatePromotion([FromBody] PromotionsDTO promotionDTO)
        {
            if(promotionDTO == null)
            {
                return BadRequest("Invalid data");
            }
            //Ánh xạ từ DTO sang Model
            var promotion = new Promotion()
            {
                PromotionName = promotionDTO.PromotionName,
                Description = promotionDTO.Description,
                StartDate = promotionDTO.StartDate,
                EndDate = promotionDTO.EndDate,
                Discount = promotionDTO.Discount,
                RestaurantId = promotionDTO.RestaurantId
            };
            _mapper.Map<Promotion>(promotionDTO);

            //Thêm vào database
            if(!_promotionsRepository.CreatePromotion(promotion))
            {
                return BadRequest("Unable to create promostion");
            }

            //Ánh xạ từ Model sang DTO
            var promotionDTOCreated = _mapper.Map<PromotionsDTO>(promotion);

            //Trả về response
            return CreatedAtAction(nameof(GetPromotionId), new { id = promotionDTOCreated.Id }, promotionDTOCreated);
        }

        // PUT: api/Promotion/update
        [HttpPut("update/{id}")]
        public IActionResult UpdatePromotion(int id, [FromBody] PromotionsDTO promotionDTO)
        {
            if (promotionDTO == null || id != promotionDTO.Id )
            {
                return BadRequest("Invalid data");
            }
            if (!_promotionsRepository.PromotionExists(id))
            {
                return NotFound();
            }
            var promotion = new Promotion()
            {
                Id = promotionDTO.Id,
                PromotionName = promotionDTO.PromotionName,
                Description = promotionDTO.Description,
                StartDate = promotionDTO.StartDate,
                EndDate = promotionDTO.EndDate,
                Discount = promotionDTO.Discount,
                RestaurantId = promotionDTO.RestaurantId,
            };
            _mapper.Map<Promotion>(promotionDTO);

            if (!_promotionsRepository.UpdatePromotion(promotion))
            {
                return BadRequest("Unable to update promotion");
            }
            return NoContent();
        }

        // DELETE: api/Promotion/delete
        [HttpDelete("{id}")]
        public IActionResult DeletePromotion(int id)
        {
            if (!_promotionsRepository.PromotionExists(id))
            {
                return NotFound();
            }
            if (!_promotionsRepository.DeletePromotion(id))
            {
                return BadRequest("Unable to delete promotion");
            }
            return NoContent();
        }

    }
}
