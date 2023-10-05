using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Microsoft.AspNetCore.Authorization;
using Restaurant.Models.RestaurantModels;
using Restaurant.Repository.Interfaces;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

namespace Restaurant.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class BillController : ControllerBase
    {
        private readonly IBillRepository _billRepository;
        private readonly IOrdersRepository _ordersRepository;
        private readonly IPromotionsRepository _promotionsRepository;
        private readonly IMapper _mapper;

        public BillController(IBillRepository billRepository, IMapper mapper, IOrdersRepository ordersRepository, IPromotionsRepository promotionsRepository)
        {
            _billRepository = billRepository;
            _mapper = mapper;
            _ordersRepository = ordersRepository;
            _promotionsRepository = promotionsRepository;
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

        // POST: api/Bill
        [HttpPost]
        [Authorize(Roles = "ADMIN,CASHIER")]
        [ProducesResponseType(201, Type = typeof(BillDTO))]
        [ProducesResponseType(400)]
        public IActionResult CreateBill([FromBody] BillDTO billDTO)
        {
            if (billDTO == null)
            {
                return BadRequest("Invalid data");
            }

            // Lấy thông tin của Order từ cơ sở dữ liệu bằng OrderId trong billDTO
            var order = _ordersRepository.GetOrderById(billDTO.OrderId);

            if (order == null)
            {
                return BadRequest("Order not found");
            }

            // Tính toán lại TotalAmount từ totalPrice của Order
            decimal? totalAmount = order.TotalPrice;

            // Kiểm tra xem Promotion có tồn tại không
            var promotion = _promotionsRepository.GetPromotionId(billDTO.PromotionId ?? 0);
            decimal? discountAmount = 0;
            // Nếu Promotion không tồn tại, đặt DiscountAmount về 0
            if (promotion != null)
            {
                discountAmount = totalAmount -(totalAmount * promotion.Discount)/100;
            }    
            else
            {
                discountAmount = totalAmount;
            }

            var bill = new Bill()
            {
                BillDate = billDTO.BillDate,
                TotalAmount = totalAmount,
                OrderId = billDTO.OrderId,
                PromotionId = billDTO.PromotionId,
                CustomerId = billDTO.CustomerId,
                DiscountAmount = discountAmount
            };

            _mapper.Map<Bill>(billDTO);

            if (!_billRepository.createBill(bill))
            {
                return BadRequest("Unable to create bill");
            }

            var createdBillDTO = _mapper.Map<BillDTO>(bill);

            return CreatedAtAction(nameof(GetBillId), new { id = createdBillDTO.Id }, createdBillDTO);
        }
        
        // PUT: api/Bill/update/{id}
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        [Authorize(Roles = "ADMIN,CASHIER")]
        public async Task<IActionResult> UpdateBill(int id, [FromBody] BillDTO billDTO)
        {
            if (billDTO == null)
            {
                return BadRequest("Invalid data");
            }

            // Kiểm tra xem bill có tồn tại không
            if (!_billRepository.BillExists(id))
            {
                return NotFound();
            }

            // Lấy thông tin bill từ cơ sở dữ liệu
            var bill = _billRepository.GetBillId(id);

            if (bill == null)
            {
                return NotFound();
            }

            // Lấy thông tin của Order từ cơ sở dữ liệu bằng OrderId trong billDTO
            var order = _ordersRepository.GetOrderById(billDTO.OrderId);

            if (order == null)
            {
                return NotFound("Order not found");
            }

            // Kiểm tra xem Promotion có tồn tại không
            var promotion = _promotionsRepository.GetPromotionId(billDTO.PromotionId ?? 0);

            // Tính toán lại TotalAmount từ totalPrice của Order và Discount của Promotion (nếu có)
            decimal? totalAmount = order.TotalPrice;
            bill.TotalAmount = totalAmount;

            if (promotion != null)
            {
                bill.DiscountAmount = bill.TotalAmount - (bill.TotalAmount * promotion.Discount)/100;
            }
            else
            {
                bill.DiscountAmount = bill.TotalAmount;
            }    

            // Cập nhật thông tin Bill
            bill.Id = billDTO.Id;
            bill.BillDate = billDTO.BillDate;
            bill.OrderId = billDTO.OrderId;
            bill.PromotionId = billDTO.PromotionId;
            bill.CustomerId = billDTO.CustomerId;
            
            

            // Thực hiện cập nhật trong database
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
        [Authorize(Roles = "ADMIN,CASHIER")]
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
