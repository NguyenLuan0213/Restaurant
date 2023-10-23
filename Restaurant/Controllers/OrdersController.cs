using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Restaurant.Data;
using Restaurant.Dto;
using Restaurant.DTO;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;
using Restaurant.Repository;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class OrdersController : ControllerBase
    {
        private readonly IOrdersRepository _ordersRepository;
        private readonly UserManager<User> _userManager;
        private readonly ITablesRepository _tablesRepository;
        private readonly IMeanRepository _meanRepository;
        private readonly RestaurantContext _context;
        private readonly IMapper _mapper;

        public OrdersController(IOrdersRepository ordersRepository, IMapper mapper, IMeanRepository meanRepository,
            UserManager<User> userManager, RestaurantContext context, ITablesRepository tablesRepository)
        {
            _ordersRepository = ordersRepository;
            _mapper = mapper;
            _meanRepository = meanRepository;
            _userManager = userManager;
            _context = context;
            _tablesRepository = tablesRepository;
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

        [HttpPost("addOrder")]
        public IActionResult CreateOrderWithMean([FromBody] OrderDTO orderDTO)
        {
            if (orderDTO == null)
            {
                return BadRequest("Dữ liệu không hợp lệ");
            }

            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Tạo đối tượng Order từ DTO
                    var order = new Order
                    {
                        TotalPrice = orderDTO.TotalPrice,
                        CashierId = orderDTO.CashierId,
                        CustomerId = orderDTO.CustomerId,
                        OrderTime = orderDTO.OrderTime,
                        Status = orderDTO.Status,
                        TableId = orderDTO.TableId,
                    };

                    // Lưu Order vào cơ sở dữ liệu
                    _context.Orders.Add(order);
                    _context.SaveChanges();

                    // Gán OrderId cho Mean
                    var mean = new Mean
                    {
                        TotalPrice = orderDTO.TotalPrice,
                        Id = order.Id, // Gán OrderId bằng Id của Order vừa được tạo
                    };

                    // Lưu Mean vào cơ sở dữ liệu
                    _context.Means.Add(mean);
                    _context.SaveChanges();

                    // Hoàn thành giao dịch
                    transaction.Commit();

                    var createOrder = _context.Orders.Find(order.Id);
                    return CreatedAtAction(nameof(GetOrderById), new { id = order.Id }, createOrder);
                }
                catch (Exception ex)
                {
                    // Giao dịch gặp lỗi, rollback
                    transaction.Rollback();
                    return BadRequest($"Lỗi: {ex.Message}");
                }
            }
        }


        // PUT: api/Orders/id
        [HttpPut("update/{id}")]
        public IActionResult UpdateOrder(int id, [FromBody] OrderDTO orderDTO)
        {
            if (orderDTO == null)
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
            order.CustomerId = orderDTO.CustomerId;

            var means = _meanRepository.GetMeanById(order.Id);

            //Tính tổng totalPrice của các Mean
            decimal? orderTotalPrice = null;

            if (means != null)
            {
                orderTotalPrice = means.TotalPrice;
            }

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

        [HttpDelete("delete/{id}")]
        public IActionResult DeleteOrder(int id)
        {
            using (var transaction = _context.Database.BeginTransaction())
            {
                try
                {
                    // Kiểm tra xem đơn đặt hàng tồn tại
                    var order = _context.Orders.Find(id);
                    if (order == null)
                    {
                        return NotFound();
                    }

                    // Lấy danh sách đối tượng Mean liên kết với đơn đặt hàng
                    var means = _context.Means.Where(m => m.Id == id).ToList();

                    // Xóa tất cả các đối tượng Mean
                    foreach (var mean in means)
                    {
                        _context.Means.Remove(mean);
                    }

                    // Thực hiện xóa đơn đặt hàng
                    _context.Orders.Remove(order);

                    _context.SaveChanges();

                    transaction.Commit();

                    return NoContent();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Unable to delete order: " + ex.Message);
                }
            }
        }


        //Phần làm về fe
        // POST: api/orders/byall
        [HttpPost("byall")]
        public IActionResult CreateOrderByAll([FromBody] OrderDTO orderDTO)
        {
            // Kiểm tra xem orderDTO có hợp lệ không, ví dụ: có dữ liệu không
            if (orderDTO == null)
            {
                return BadRequest(new { message = "Dữ liệu đầu vào không hợp lệ" });
            }

            try
            {
                // Trích xuất thông tin từ orderDTO
                var cashierId = orderDTO.CashierId;
                var tableId = orderDTO.TableId;
                var totalPrice = orderDTO.TotalPrice ?? 0;
                var status = orderDTO.Status;
                var orderTime = orderDTO.OrderTime;

                // Kiểm tra xem orderDTO có hợp lệ không, ví dụ: kiểm tra các thông tin bắt buộc
                if (cashierId == Guid.Empty || tableId < 0 || totalPrice < 0)
                {
                    return BadRequest(new { message = "Thông tin đặt hàng không hợp lệ" });
                }

                // Xây dựng danh sách MeanItem từ orderDTO
                var meanItemDTOs = orderDTO.MeanItems;

                // Chuyển đổi MeanItemDTO thành danh sách MeanItem
                var meanItems = meanItemDTOs.Select(dto => new Meanitem
                {
                    MenuItemId = dto.MenuItemId,
                    Quantity = dto.Quantity,
                    TotalPrice = dto.TotalPrice ?? 0
                }).ToList();

                // Kiểm tra xem danh sách MeanItem có dữ liệu không
                if (meanItems.Count == 0)
                {
                    return BadRequest(new { message = "Danh sách mặt hàng không hợp lệ" });
                }

                // Trích xuất thông tin khách hàng từ orderDTO
                var customerId = orderDTO.CustomerId;
                User customer = null;

                if (!customerId.HasValue)
                {
                    var email = orderDTO.Customer.Email;
                    var username = email.Split('@')[0];
                    var uniqueUsername = $"{username}_{DateTime.Now.Ticks}";
                    // Tạo một người dùng mới nếu customerId không được cung cấp
                    customer = new User
                    {
                        UserName = username,
                        Fullname = orderDTO.Customer.Fullname,
                        Email = email,
                        PhoneNumber = orderDTO.Customer.PhoneNumber
                    };
                    var tempPassword = "P@ssw0rdtmp";
                    // Thêm người dùng mới vào cơ sở dữ liệu và gán quyền CUSTOMER
                    var result = _userManager.CreateAsync(customer, tempPassword).Result;

                    if (result.Succeeded)
                    {
                        _userManager.AddToRoleAsync(customer, "CUSTOMER").Wait();
                    }
                    else
                    {
                        return BadRequest(new { message = "Không thể tạo người dùng mới" });
                    }
                }
                else
                {
                    // Kiểm tra xem người dùng đã tồn tại trong cơ sở dữ liệu
                    customer = _context.Users.FirstOrDefault(u => u.Id == customerId);
                }

                // Gọi hàm CreateNewOrder để tạo order mới và trả về đối tượng order được tạo
                var newOrder = _ordersRepository.CreateNewOrder(cashierId, tableId, totalPrice, status, meanItems, orderTime, customerId, customer);

                return CreatedAtAction(nameof(GetOrderId), new { id = newOrder.Id }, newOrder);
            }
            catch (Exception ex)
            {
                // Xử lý bất kỳ lỗi nào xảy ra trong quá trình xử lý yêu cầu
                return StatusCode(500, new { message = "Đã xảy ra lỗi trong quá trình xử lý yêu cầu" });
            }
        }

        [HttpPut("paySuccces/{orderId}")]
        public IActionResult UpdateOrderAndTableStatus(int orderId, [FromBody] OrderUpdateDTO status)
        {
            var order = _context.Orders.FirstOrDefault(o => o.Id == orderId);

            if (order == null)
            {
                return NotFound("Không tìm thấy đơn hàng");
            }

            // Kiểm tra trạng thái của đơn hàng
            if (status.Status == "Đã thanh toán")
            {
                // Cập nhật trạng thái của đơn hàng thành "Đã thanh toán"
                order.Status = status.Status;

                // Tạo một hóa đơn mới và tính giảm giá nếu PromotionId có
                var bill = new Bill
                {
                    OrderId = orderId,
                    BillDate = DateTime.Now,
                    TotalAmount = order.TotalPrice,
                    CustomerId = order.CustomerId,
                    PromotionId = status.PromotionId // PromotionId từ DTO, có thể null
                };

                if (status.PromotionId.HasValue)
                {
                    var promotion = _context.Promotions.FirstOrDefault(p => p.Id == status.PromotionId);
                    if (promotion != null)
                    {
                        // Tính toán giảm giá và cập nhật
                        bill.DiscountAmount = order.TotalPrice - (order.TotalPrice * promotion.Discount)/100;
                    }
                }
                else
                {
                    // Nếu không có Promotion, discount_amount = totalmount
                    bill.DiscountAmount = order.TotalPrice;
                }

                _context.Bills.Add(bill);
            }
            else if (status.Status == "Đã hủy")
            {
                // Nếu trạng thái là "Đã hủy", chỉ cập nhật trạng thái của bàn
                order.Status = status.Status;
            }
            else
            {
                return BadRequest("Không thể cập nhật trạng thái của đơn hàng và bàn ăn");
            }

            _context.SaveChanges();

            // Cập nhật trạng thái của bàn ăn thành "Chưa đặt"
            var table = _context.Tables.FirstOrDefault(t => t.Id == order.TableId);
            if (table != null)
            {
                table.Status = "Chưa đặt";
                _context.SaveChanges();
            }

            return Ok("Cập nhật trạng thái đơn hàng và bàn ăn thành công");
        }



        //Get payment id
        [HttpGet("pay/{id}")]
        public IActionResult GetOrderById(int id)
        {
            try
            {
                // Lấy đơn hàng theo id từ cơ sở dữ liệu, bao gồm thông tin của Means và MeanItems
                var order = _context.Orders
                    .Include(o => o.Means)
                    .ThenInclude(m => m.Meanitems)
                    .Include(o => o.Customer)
                    .FirstOrDefault(o => o.Id == id);

                if (order == null)
                {
                    return NotFound(new { message = "Không tìm thấy đơn hàng" });
                }

                var table = _context.Tables.FirstOrDefault(t => t.Id == order.TableId);
                if (table == null)
                {
                    return NotFound(new { message = "Không tìm thấy bàn nào cho đơn hàng này" });
                }

                // Chuyển đổi đơn hàng thành đối tượng DTO
                var orderDTO = new OrderDTO
                {
                    Id = order.Id,
                    CashierId = order.CashierId,
                    Tables = new TablesDTO
                    {
                        Id = table.Id,
                        Seats = table.Seats,
                        Status = table.Status,
                        RestaurantId = table.RestaurantId,
                        TableNumber = table.TableNumber,
                    },
                    TotalPrice = order.TotalPrice,
                    Status = order.Status,
                    OrderTime = order.OrderTime,
                    CustomerId = order.CustomerId,
                    // Kiểm tra xem order.Customer có giá trị null không
                    Customer = order.Customer != null ? new UsersDTO
                    {
                        Id = order.Customer.Id,
                        Fullname = order.Customer.Fullname,
                        Email = order.Customer.Email,
                        PhoneNumber = order.Customer.PhoneNumber
                    } : null,
                    MeanItems = order.Means.Meanitems.Select(meanItem => new MeanItemDTO
                    {
                        Id = meanItem.Id,
                        MeanId = meanItem.MeanId,
                        MenuItemId = meanItem.MenuItemId,
                        Quantity = meanItem.Quantity ?? 0,
                        TotalPrice = meanItem.TotalPrice
                    }).ToList()
                };

                return Ok(orderDTO);
            }
            catch (Exception ex)
            {
                // Xử lý bất kỳ lỗi nào xảy ra trong quá trình xử lý yêu cầu
                return StatusCode(500, new { message = "Đã xảy ra lỗi trong quá trình xử lý yêu cầu" });
            }
        }

        //Get payment by phone
        [HttpGet("pay/customer/{phoneNumber}")]
        public IActionResult GetOrdersByCustomerPhoneNumber(string phoneNumber)
        {
            try
            {
                // Kiểm tra xem có khách hàng nào có số điện thoại này không
                var customer = _context.Users.FirstOrDefault(u => u.PhoneNumber == phoneNumber);

                if (customer == null)
                {
                    return NotFound(new { message = "Không tìm thấy khách hàng có số điện thoại này trong hệ thống" });
                }

                // Kiểm tra xem khách hàng đã đặt đơn hàng nào chưa
                var orders = _context.Orders
                    .Where(o => o.CustomerId == customer.Id)
                    .Include(o => o.Means)
                    .ThenInclude(m => m.Meanitems)
                    .Include(o => o.Customer)
                    .ToList();

                if (orders.Count == 0)
                {
                    return NotFound(new { message = "Không tìm thấy đơn hàng nào cho khách hàng này" });
                }

                // Chuyển đổi danh sách đơn hàng thành danh sách đơn hàng DTO
                var orderDTOs = new List<OrderDTO>();

                foreach (var order in orders)
                {
                    var table = _context.Tables.FirstOrDefault(t => t.Id == order.TableId);
                    if (table == null)
                    {
                        return NotFound(new { message = "Không tìm thấy bàn nào cho đơn hàng này" });
                    }

                    var orderDTO = new OrderDTO
                    {
                        Id = order.Id,
                        CashierId = order.CashierId,
                        Tables = new TablesDTO
                        {
                            Id = table.Id,
                            Seats = table.Seats,
                            Status = table.Status,
                            RestaurantId = table.RestaurantId,
                            TableNumber = table.TableNumber,
                        },
                        TotalPrice = order.TotalPrice,
                        Status = order.Status,
                        OrderTime = order.OrderTime,
                        CustomerId = order.CustomerId,
                        Customer = order.Customer != null ? new UsersDTO
                        {
                            Id = order.Customer.Id,
                            Fullname = order.Customer.Fullname,
                            Email = order.Customer.Email,
                            PhoneNumber = order.Customer.PhoneNumber
                        } : null,
                        MeanItems = order.Means.Meanitems.Select(meanItem => new MeanItemDTO
                        {
                            Id = meanItem.Id,
                            MeanId = meanItem.MeanId,
                            MenuItemId = meanItem.MenuItemId,
                            Quantity = meanItem.Quantity ?? 0,
                            TotalPrice = meanItem.TotalPrice
                        }).ToList()
                    };

                    orderDTOs.Add(orderDTO);
                }

                return Ok(orderDTOs);
            }
            catch (Exception ex)
            {
                // Xử lý bất kỳ lỗi nào xảy ra trong quá trình xử lý yêu cầu
                return StatusCode(500, new { message = "Đã xảy ra lỗi trong quá trình xử lý yêu cầu" });
            }
        }

        [HttpGet("cancelOrders")]
        public IActionResult GetCancelOrderCount()
        {
            // Đếm số đơn hàng có Status là "Đã hủy"
            int cancelOrderCount = _context.Orders.Count(order => order.Status == "Đã hủy");

            return Ok(new { CancelOrderCount = cancelOrderCount });
        }

    }
}