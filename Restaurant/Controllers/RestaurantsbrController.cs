using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Data;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class RestaurantsbrController :ControllerBase
    {
        private readonly IRestaurantsbrRepository _resrepo;
        private readonly IMapper _mapper;

        public RestaurantsbrController(IRestaurantsbrRepository resrepo, RestaurantContext restcontext, IMapper mapper)
        {
            _resrepo = resrepo;
            this._mapper = mapper;
        }

        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Restaurantsbr>))]
        public IActionResult GetRestaurantsbrs()
        {
            var restaurantsbrs = _mapper.Map<List<RestaurantsbrDTO>>(_resrepo.GetRestaurantsbrs());

            if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
            return Ok(restaurantsbrs);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Restaurantsbr))]
        [ProducesResponseType(400)]
        public IActionResult GetRestaurantsbrs(int id)
        {
            if(!_resrepo.RestaurantsbrExists(id))
            {
                return NotFound();
            }

            var restaurantsbr = _mapper.Map<RestaurantsbrDTO>(_resrepo.GetRestaurantsbr(id));
            
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            return Ok(restaurantsbr);
        }

        // Post api/restaurantsbr
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(RestaurantsbrDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateRestaurant([FromBody] RestaurantsbrDTO restaurantDTO)
        {
            if (restaurantDTO == null)
            {
                return BadRequest("Invalid data");
            }

            // Ánh xạ DTO thành đối tượng Restaurantsbr
            var restaurant = new Restaurantsbr()
            {
                Name = restaurantDTO.Name,
                Address = restaurantDTO.Address,
                Description = restaurantDTO.Description
            };

            _mapper.Map<Restaurantsbr>(restaurantDTO);

            // Thực hiện thêm nhà hàng vào cơ sở dữ liệu
            if (!_resrepo.CreateRestaurantsbr(restaurant))
            {
                return BadRequest("Unable to create restaurant");
            }

            // Ánh xạ lại đối tượng thành DTO để trả về cho client
            var createdRestaurantDTO = _mapper.Map<RestaurantsbrDTO>(restaurant);

            // Trả về mã trạng thái 201 Created và đối tượng đã được tạo
            return CreatedAtAction(nameof(GetRestaurantsbrs), new { id = createdRestaurantDTO.Id }, createdRestaurantDTO);
        }


        // PUT api/restaurantsbr/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateRestaurant(int id, [FromBody] RestaurantsbrDTO restaurantDTO)
        {
            if (restaurantDTO == null || id != restaurantDTO.Id)
            {
                return BadRequest("Invalid data");
            }
            // Kiểm tra xem nhà hàng có tồn tại không
            if (!_resrepo.RestaurantsbrExists(id))
            {
                return NotFound();
            }
            // Ánh xạ DTO thành đối tượng Restaurantsbr
            var restaurant = new Restaurantsbr()    
            {
                Id = restaurantDTO.Id,
                Name = restaurantDTO.Name,
                Address = restaurantDTO.Address,
                Description = restaurantDTO.Description
            };
            _mapper.Map<Restaurantsbr>(restaurantDTO);
            // Thực hiện cập nhật nhà hàng vào cơ sở dữ liệu
            if (!_resrepo.UpdateRestaurantsbr(restaurant))
            {
                return BadRequest("Unable to update restaurant");
            }
            // Trả về mã trạng thái 204 No Content
            return NoContent();
        }

        // DELETE api/restaurantsbr/id
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteRestaurant(int id)
        {
            // Kiểm tra xem nhà hàng có tồn tại không
            if (!_resrepo.RestaurantsbrExists(id))
            {
                return NotFound();
            }
            // Thực hiện xóa nhà hàng khỏi cơ sở dữ liệu
            if (!_resrepo.DeleteRestaurantsbr(id))
            {
                return BadRequest("Unable to delete restaurant");
            }
            // Trả về mã trạng thái 204 No Content
            return NoContent();
        }
        
    }
}
