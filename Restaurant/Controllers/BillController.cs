using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Microsoft.AspNetCore.Authorization;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class BillController : ControllerBase
    {
        private readonly IBillRepository _billRepository;
        private readonly IMapper _mapper;

        public BillController(IBillRepository billRepository, IMapper mapper)
        {
            _billRepository = billRepository;
            _mapper = mapper;
        }

        // GET: api/Bill
        [HttpGet]
        //[ProducesResponseType(200, Type = typeof(IEnumerable<Bill>))]
        public IActionResult GetBills()
        {
            var bill = _mapper.Map<List<BillDTO>>(_billRepository.GetBills());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(bill);
        }

        //Get: api/Bill/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Bill))]
        [ProducesResponseType(400)]
        public IActionResult GetBillId(int id)
        {
            if (!_billRepository.BillExists(id))
            {
                return NotFound();
            }
            var bill = _mapper.Map<BillDTO>(_billRepository.GetBillId(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(bill);
        }

        [HttpGet("date/{date}")]
        [ProducesResponseType(200, Type = typeof(List<BillDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetBillsByDate(DateTime date)
        {
            var bills = _billRepository.GetBillsByBillDate(date);

            if (bills == null || bills.Count == 0)
            {
                return NotFound();
            }

            var billDTOs = _mapper.Map<List<BillDTO>>(bills);

            return Ok(billDTOs);
        }

        //Get: api/Bill/orderid
        [HttpGet("order/{OrderId}")]
        [ProducesResponseType(200, Type = typeof(ICollection<BillDTO>))]
        [ProducesResponseType(404)]
        public IActionResult GetBillByOrderId(int OrderId)
        {
            var bills = _billRepository.GetBillsByOrderId(OrderId);

            if (bills == null || !bills.Any())
            {
                return NotFound();
            }

            var billDTOs = _mapper.Map<ICollection<BillDTO>>(bills);
            return Ok(billDTOs);
        }

        //Get: api/Bill/promotion
        [HttpGet("promotion/{PromotionId}")]
        [ProducesResponseType(200, Type = typeof(ICollection<BillDTO>))]
        [ProducesResponseType(404)]
        public IActionResult GetBillByPromotionId(int PromotionId)
        {
            var bills = _billRepository.GetBillsByPromotionId(PromotionId);

            if (bills == null || !bills.Any())
            {
                return NotFound();
            }

            var billDTOs = _mapper.Map<ICollection<BillDTO>>(bills);
            return Ok(billDTOs);
        }

        //post: api/Bill
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(BillDTO))]
        [ProducesResponseType(400)]
        public IActionResult CreateBill([FromBody] BillDTO billDTO)
        {
            if (billDTO == null)
            {
                return BadRequest("Invalid data");
            }

            var bill = new Bill()
            {
                BillDate = billDTO.BillDate,
                TotalAmount = billDTO.TotalAmount,
                OrderId = billDTO.OrderId,
                PromotionId = billDTO.PromotionId,
                CustomerId = billDTO.CustomerId,
                DiscountAmount = billDTO.DiscountAmount
            };

            _mapper.Map<Bill>(billDTO);

            if (!_billRepository.createBill(bill))
            {
                return BadRequest("Unable to create bill");
            }

            var createBillDTO = _mapper.Map<BillDTO>(bill);

            return CreatedAtAction(nameof(GetBillId), new { id = createBillDTO.Id }, createBillDTO);
        }

        //put: api/Bill/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateBill(int id, [FromBody] BillDTO billDTO)
        {
            if (billDTO == null || id != billDTO.Id)
            {
                return BadRequest("Invalid data");
            }
            //Kiểm tra xem bill có tồn tại không
            if (!_billRepository.BillExists(id))
            {
                return NotFound();
            }
            //Ánh xạ dữ liệu từ DTO sang Model
            var bill = new Bill()
            {
                Id = billDTO.Id,
                BillDate = billDTO.BillDate,
                TotalAmount = billDTO.TotalAmount,
                OrderId = billDTO.OrderId,
                PromotionId = billDTO.PromotionId,
                CustomerId = billDTO.CustomerId,
                DiscountAmount = billDTO.DiscountAmount
            };
            _mapper.Map<Bill>(billDTO);

            //Thực hiện cập nhật trong database
            if (!_billRepository.updateBill(bill))
            {
                return BadRequest("Unable to update bill");
            }

            return NoContent();
        }

        // DELETE: api/Bill/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteBill(int id)
        {
            if (!_billRepository.BillExists(id))
            {
                return NotFound();
            }

            if (!_billRepository.deleteBill(id))
            {
                return BadRequest("Unable to delete bill");
            }

            return NoContent();
        }
    }
}
