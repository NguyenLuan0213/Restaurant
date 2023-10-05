using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly IOrdersRepository _ordersRepository;
        private readonly IMeanRepository _meanRepository;
        private readonly IMapper _mapper;

        public OrdersController(IOrdersRepository ordersRepository, IMapper mapper, IMeanRepository meanRepository)
        {
            _ordersRepository = ordersRepository;
            _mapper = mapper;
            _meanRepository = meanRepository;
        }

        // GET: api/Orders
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Order>))]
        public IActionResult GetOrders()
        {
            var orders = _mapper.Map<List<OrderDTO>>(_ordersRepository.GetOrders());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(orders);
        }

        //Get: api/Orders/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Order))]
        [ProducesResponseType(400)]
        public IActionResult GetOrderId(int id)
        {
            if (!_ordersRepository.OrderExists(id))
            {
                return NotFound();
            }
            var order = _mapper.Map<OrderDTO>(_ordersRepository.GetOrderById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(order);
        }

        // GET: api/Orders/date
        [HttpGet("date/{date}")]
        [ProducesResponseType(200, Type = typeof(List<OrderDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetOrdersByDate(DateTime date)
        {
            var orders = _ordersRepository.GetOrdersByOrderDate(date);

            if (orders == null || orders.Count == 0)
            {
                return NotFound();
            }

            var orderDTOs = _mapper.Map<List<OrderDTO>>(orders);

            return Ok(orderDTOs);
        }

        // GET: api/Orders/status
        [HttpGet("status/{status}")]
        [ProducesResponseType(200, Type = typeof(List<OrderDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetOrdersByOrderStatus(String status)
        {
            var orders = _ordersRepository.GetOrdersByOrderStatus(status);

            if (orders == null || orders.Count == 0)
            {
                return NotFound();
            }

            var orderDTOs = _mapper.Map<List<OrderDTO>>(orders);

            return Ok(orderDTOs);
        }

        // GET: api/Orders/table
        [HttpGet("table/{tableId}")]
        [ProducesResponseType(200, Type = typeof(List<OrderDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetOrdersByTableId(int tableId)
        {
            var orders = _ordersRepository.GetOrdersByTableId(tableId);

            if (orders == null || !orders.Any())
            {
                return NotFound();
            }

            var ordersDTOs = _mapper.Map<ICollection<OrderDTO>>(orders);
            return Ok(ordersDTOs);
        }

        // Get: api/Orders/cashierId
        [HttpGet("cashier/{cashierId}")]
        [ProducesResponseType(201, Type = typeof(List<OrderDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetOrdersByCashierId(Guid cashierId)
        {
            var orders = _ordersRepository.GetOrdersByCashierId(cashierId);
            if (orders == null || orders.Count == 0)
            {
                return NotFound();
            }
            var orderDTOs = _mapper.Map<List<OrderDTO>>(orders);

            return Ok(orderDTOs);
        }

        // POST: api/Orders
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(OrderDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateOrder([FromBody] OrderDTO orderDTO)
        {
            if (orderDTO == null)
            {
                return BadRequest("Invalid data");
            }
            // Tạo một đối tượng Order từ orderDTO
            var order = _mapper.Map<Order>(orderDTO);

            // Lấy danh sách Mean của Order
            var means = _meanRepository.GetMeanByOrderId(order.Id);

            // Tính tổng totalPrice từ các Mean
            decimal? orderTotalPrice = means.Sum(mean => mean.TotalPrice);

            // Cập nhật totalPrice của Order
            order.TotalPrice = orderTotalPrice ?? 0;


            _mapper.Map<Order>(orderDTO);

            // Thực hiện thêm mới
            if (!_ordersRepository.CreateOrder(order))
            {
                return BadRequest("Unable to create order");
            }

            //Ánh xạ lại đối tượng thành DTO để trả về client
            var createrderDTO = _mapper.Map<OrderDTO>(order);

            //Trả về mã 201 - Created
            return CreatedAtAction(nameof(GetOrderId), new { id = createrderDTO.Id }, createrderDTO);
        }

        // PUT: api/Orders/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateOrder(int id, [FromBody] OrderDTO orderDTO)
        {
            if (orderDTO == null )
            {
                return BadRequest("Invalid data");
            }
            //Kiểm tra xem order có tồn tại không
            if (!_ordersRepository.OrderExists(id))
            {
                return NotFound();
            }
            //Lấy order theo Id
            var order = _ordersRepository.GetOrderById(id);
            if (order == null)
            {
                return NotFound();
            }
            //Ánh xạ lại đối tượng thành DTO để trả về client
            order.Id = orderDTO.Id;
            order.OrderTime = orderDTO.OrderTime;
            order.Status = orderDTO.Status;
            order.TableId = orderDTO.TableId;
            order.CashierId = orderDTO.CashierId;

            var means = _meanRepository.GetMeanByOrderId(order.Id);

            // Tính tổng totalPrice của các Mean
            decimal? orderTotalPrice = means.Sum(mean => mean.TotalPrice);

            // Gán giá trị totalPrice cho Order
            order.TotalPrice = orderTotalPrice;

            _mapper.Map<Order>(orderDTO);

            //Thực hiện cập nhật
            if (!_ordersRepository.UpdateOrder(order))
            {
                return BadRequest("Unable to update order");
            }
            //Trả về mã 204 - NoContent
            return NoContent();
        }

        // DELETE: api/Orders/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteOrder(int id)
        {
            //Kiểm tra xem order có tồn tại không
            if (!_ordersRepository.OrderExists(id))
            {
                return NotFound();
            }
            //Thực hiện xóa
            if (!_ordersRepository.DeleteOrder(id))
            {
                return BadRequest("Unable to delete order");
            }
            //Trả về mã 204 - NoContent
            return NoContent();
        }
    }
}
