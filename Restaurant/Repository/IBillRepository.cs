using Restaurant.Models;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface IBillRepository
    {
        ICollection<Bill> GetBills();

        Bill GetBillId(int id);

        Bill GetBillByBillDate(DateTime BillDate);

        Bill GetBillByTotalAmount(decimal TotalAmount);

        Bill GetBillByDiscountAmount(decimal DiscountAmount);

        ICollection<Bill> GetBillsByCustomerId(int customerId);

        //ICollection<Bill> GetBillsByCustomerName(string customerName);
        ICollection<Bill> GetBillsByBillDate(DateTime BillDate);

        ICollection<Bill> GetBillsByPromotionId(int promotionId);

        ICollection<Bill> GetBillsByOrderId(int orderId);
        bool createBill(Bill bill);
        bool updateBill(Bill bill);
        bool deleteBill(int id);
        bool Save();

        bool BillExists(int id);
    }
}
