using Microsoft.AspNetCore.Identity;
using Restaurant.Data;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;

namespace Restaurant.Repository.Interfaces
{
    public class OrdersRepository : IOrdersRepository
    {
        private readonly RestaurantContext _context;
        private readonly UserManager<User> _userManager;

        public OrdersRepository(RestaurantContext context, UserManager<User> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        public bool CreateOrder(Order order)
        {
            try
            {
                _context.Orders.Add(order);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool UpdateOrder(Order order)
        {
            try
            {
                var resultOrder = _context.Orders.FirstOrDefault(r => r.Id == order.Id);

                if (resultOrder != null)
                {
                    resultOrder.Cashier = order.Cashier;
                    resultOrder.TableId = order.TableId;
                    resultOrder.OrderTime = order.OrderTime;
                    resultOrder.Status = order.Status;
                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    return true; // Trả về true nếu cập nhật thành công
                }
                else
                {
                    return false; // Trả về false nếu không tìm thấy order
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteOrder(int id)
        {
            var order = _context.Orders.FirstOrDefault(o => o.Id == id);
            if (order == null)
            {
                return false;// Không tìm thấy order
            }

            try
            {
                _context.Orders.Remove(order); // Xóa order
                return Save(); // Gọi hàm Save để lưu thay đổi và trả về kết quả
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi tại đây nếu cần thiết, ví dụ: ghi log hoặc trả về false
            }
        }

        public Order GetOrderById(int id)
        {
            return _context.Orders.Where(o => o.Id == id).FirstOrDefault();
        }

        public Order GetOrderByOrderDate(DateTime OrderDate)
        {
            return _context.Orders.Where(o => o.OrderTime == OrderDate).FirstOrDefault();
        }

        public Order GetOrderByOrderStatus(string Status)
        {
            return _context.Orders.Where(o => o.Status == Status).FirstOrDefault();
        }

        public ICollection<Order> GetOrders()
        {
            return _context.Orders.OrderBy(o => o.Id).ToList();
        }

        public ICollection<Order> GetOrdersByCashierId(Guid cashierId)
        {
            return _context.Orders.Where(o => o.CashierId == cashierId).ToList();
        }

        public ICollection<Order> GetOrdersByOrderDate(DateTime OrderDate)
        {
            return _context.Orders.Where(o => o.OrderTime.Date == OrderDate.Date).ToList();
        }

        public ICollection<Order> GetOrdersByOrderStatus(string Status)
        {
            return _context.Orders.Where(o => o.Status == Status).ToList();
        }

        public ICollection<Order> GetOrdersByTableId(int tableId)
        {
            return _context.Orders.Where(o => o.TableId == tableId).ToList();
        }

        public bool OrderExists(int id)
        {
            return _context.Orders.Any(o => o.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public Order CreateNewOrder(Guid? cashierId, int? tableId, decimal totalPrice, string status, List<Meanitem> meanItems, DateTime orderTime, Guid? customerId, User customer)
        {
            if (!customerId.HasValue)
            {
                customerId = customer.Id;
            }
            else
            {
                // Kiểm tra xem người dùng đã tồn tại trong cơ sở dữ liệu
                var existingCustomer = _context.Users.FirstOrDefault(u => u.Id == customerId);

                if (existingCustomer != null)
                {
                    customer = existingCustomer;
                }
            }

            // Tạo một đối tượng Order mới
            var newOrder = new Order
            {
                CashierId = cashierId,
                CustomerId = customerId,
                TableId = tableId,
                TotalPrice = totalPrice,
                Status = status,
                OrderTime = orderTime, // Set thời gian cho đơn hàng
            };

            // Tạo một đối tượng Mean mới
            var newMean = new Mean
            {
                Description = "Mô tả của Mean",
                TotalPrice = 0 // Tạm thời đặt giá trị TotalPrice của Mean là 0
            };

            // Liên kết Order và Mean bằng mối quan hệ 1-1
            newOrder.Means = newMean;

            // Thêm các MeanItem vào Mean
            if (meanItems != null && meanItems.Any())
            {
                foreach (var meanItem in meanItems)
                {
                    meanItem.MeanId = newMean.Id; // Gán MeanId của MeanItem
                    newMean.Meanitems.Add(meanItem);
                    newMean.TotalPrice += meanItem.TotalPrice;
                }
            }
            // Thêm Order mới vào cơ sở dữ liệu
            _context.Orders.Add(newOrder);

            var table = _context.Tables.FirstOrDefault(t => t.Id == tableId);

            if (table != null)
            {
                // Thay đổi trạng thái của bàn (ví dụ: Đã đặt hàng)
                table.Status = "Đang đặt";

                // Cập nhật thông tin bàn vào cơ sở dữ liệu
                _context.Tables.Update(table);
            }

            // Lưu thay đổi vào cơ sở dữ liệu
            _context.SaveChanges();

            return newOrder;
        }


    }
}