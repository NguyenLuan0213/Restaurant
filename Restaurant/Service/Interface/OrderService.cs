using Restaurant.Data;

namespace Restaurant.Service.Interface
{
    public class OrderService : IOrderService
    {
        private readonly RestaurantContext _context;

        public OrderService(RestaurantContext context)
        {
            _context = context;
        }

        public async Task CheckAndUpdateOrderStatusAsync()
        {
            var currentTime = DateTime.UtcNow;

            // Lấy tất cả các đơn hàng cần cập nhật
            var ordersToUpdate = _context.Orders
                .Where(o => o.OrderTime <= currentTime && o.Status != "Đã thanh toán")
                .ToList();

            if (ordersToUpdate.Any())
            {
                using (var transaction = _context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var order in ordersToUpdate)
                        {
                            // Cập nhật trạng thái của đơn hàng và bàn tương ứng
                            order.Status = "Đã thanh toán";

                            // Cập nhật trạng thái của bàn
                            var table = _context.Tables.FirstOrDefault(t => t.Id == order.TableId);
                            if (table != null)
                            {
                                table.Status = "Đang đặt";
                            }
                        }

                        // Lưu thay đổi vào cơ sở dữ liệu
                        await _context.SaveChangesAsync();

                        // Commit transaction nếu tất cả cập nhật thành công
                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        // Xử lý lỗi nếu có
                        transaction.Rollback();
                        throw; // Ném lỗi lên để xử lý ở lớp gọi
                    }
                }
            }
        }
    }
}