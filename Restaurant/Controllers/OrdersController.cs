using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly IOrdersRepository _ordersRepository;
        private readonly IMapper _mapper;

        public OrdersController(IOrdersRepository ordersRepository, IMapper mapper)
        {
            _ordersRepository = ordersRepository;
            _mapper = mapper;
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
        public IActionResult GetOrdersByCashierId(int cashierId)
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
            var order = new Order()
            {
                OrderTime = orderDTO.OrderTime,
                Status = orderDTO.Status,
                TableId = orderDTO.TableId,
                CashierId = orderDTO.CashierId
            };

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
            if (orderDTO == null || id != orderDTO.Id)
            {
                return BadRequest("Invalid data");
            }
            //Kiểm tra xem order có tồn tại không
            if (!_ordersRepository.OrderExists(id))
            {
                return NotFound();
            }

            //Ánh xạ lại đối tượng thành DTO để trả về client
            var order = new Order()
            {
                Id = orderDTO.Id,
                OrderTime = orderDTO.OrderTime,
                Status = orderDTO.Status,
                TableId = orderDTO.TableId,
                CashierId = orderDTO.CashierId
            };
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
