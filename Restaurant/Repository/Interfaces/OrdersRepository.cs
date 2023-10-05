using Microsoft.EntityFrameworkCore;
using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class OrdersRepository : IOrdersRepository
    {
        private readonly RestaurantContext _context;

        public OrdersRepository(RestaurantContext context)
        {
            _context = context;
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
    }
}
