using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;

namespace Restaurant.Repository
{
    public interface IOrdersRepository
    {
        ICollection<Order> GetOrders();
        Order GetOrderById(int id);
        Order GetOrderByOrderDate(DateTime OrderDate);
        Order GetOrderByOrderStatus(string Status);
        ICollection<Order> GetOrdersByCashierId(Guid cashierId);
        ICollection<Order> GetOrdersByOrderDate(DateTime OrderDate);
        ICollection<Order> GetOrdersByOrderStatus(string Status);
        ICollection<Order> GetOrdersByTableId(int tableId);
        Order CreateNewOrder(Guid? cashierId, int? tableId, decimal totalPrice, string status, List<Meanitem> meanItems, DateTime orderTime, Guid? customerId, User customer);
        bool CreateOrder(Order order);
        bool UpdateOrder(Order order);
        bool DeleteOrder(int id);
        bool Save();
        bool OrderExists(int id);


    }
}
