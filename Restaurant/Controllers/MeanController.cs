using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.DTO;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class MeanController : ControllerBase
    {
        private readonly IMeanRepository _meanRepository;
        private readonly IMeanItemRepository _meanItemRepository;
        private readonly IMapper _mapper;

        public MeanController(IMeanRepository meanRepository, IMapper mapper, IMeanItemRepository meanItemRepository)
        {
            _meanRepository = meanRepository;
            _meanItemRepository = meanItemRepository;
            _mapper = mapper;
        }

        // GET: api/Mean
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Mean>))]
        public IActionResult GetMeans()
        {
            var mean = _mapper.Map<List<MeanDTO>>(_meanRepository.GetMeans());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(mean);
        }

        // GET: api/Mean/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Mean))]
        [ProducesResponseType(400)]
        public IActionResult GetMean(int id)
        {
            if (!_meanRepository.MeanExists(id))
            {
                return NotFound();
            }
            var mean = _mapper.Map<MeanDTO>(_meanRepository.GetMeanById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(mean);
        }

        // GET: api/Mean/orderId
        [HttpGet("order/{orderId}")]
        [ProducesResponseType(200, Type = typeof(Mean))]
        [ProducesResponseType(400)]
        public IActionResult GetMeanByOrderId(int orderId)
        {
            if (!_meanRepository.MeanExists(orderId))
            {
                return NotFound();
            }

            var mean = _meanRepository.GetMeanByOrderId(orderId);
            if (mean == null || !mean.Any())
            {
                return BadRequest();
            }
            var meanDTO = _mapper.Map<ICollection<MeanDTO>>(mean);
            return Ok(meanDTO);
        }

        // POST: api/Mean
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(MeanDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(500)]
        public IActionResult CreateMean([FromBody] MeanDTO meanDTO)
        {
            if (meanDTO == null)
            {
                return BadRequest("Invalid data");
            }

            var mean = new Mean()
            {
                OrderId = meanDTO.OrderId,
                Description = meanDTO.Description,
            };

            // Lấy danh sách MeanItem dựa trên mean.Id
            var meanItems = _meanItemRepository.GetMeanIteamByMeanId(mean.Id);

            // Tính tổng totalPrice của các MeanItem
            decimal? totalPrice = meanItems.Sum(item => item.TotalPrice);

            // Cập nhật giá trị totalPrice của Mean
            mean.TotalPrice = totalPrice;

            _mapper.Map<Mean>(meanDTO);

            if (!_meanRepository.CreateMean(mean))
            {
                return BadRequest("Unable to create mean");
            }

            var CreatedMeanDTO = _mapper.Map<MeanDTO>(mean);

            return CreatedAtAction(nameof(GetMean), new { id = CreatedMeanDTO.Id }, CreatedMeanDTO);
        }

        // PUT: api/Mean/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateMean(int id, [FromBody] MeanDTO meanDTO)
        {
            if (meanDTO == null)
            {
                return BadRequest("Invalid data");
            }

            // Kiểm tra xem mean có tồn tại không
            var mean = _meanRepository.GetMeanById(id);
            if (mean == null)
            {
                return NotFound();
            }

            // Ánh xạ meanDTO sang mean
            mean.Id = meanDTO.Id;
            mean.Description = meanDTO.Description;
            mean.OrderId = meanDTO.OrderId;

            // Lấy danh sách MeanItem có cùng meanId
            var meanItems = _meanItemRepository.GetMeanIteamByMeanId(id);

            // Tính tổng totalPrice của các MeanItem
            decimal? totalPrice = meanItems.Sum(item => item.TotalPrice);

            // Cập nhật giá trị totalPrice của Mean
            mean.TotalPrice = totalPrice;

            // Thực hiện update mean vào database
            if (!_meanRepository.UpdateMean(mean))
            {
                return BadRequest("Unable to update mean");
            }

            // Trả về response code 204 - No Content sau khi update thành công
            return NoContent();
        }



        // DELETE: api/Mean/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteMean(int id)
        {
            //Kiểm tra xem mean có tồn tại không
            if (!_meanRepository.MeanExists(id))
            {
                return NotFound();
            }
            //Thực hiện xóa mean trong database
            if (!_meanRepository.DeleteMean(id))
            {
                return BadRequest("Unable to delete mean");
            }
            //Trả về response code 204 - No Content sau khi xóa thành công
            return NoContent();
        }
    }
}
