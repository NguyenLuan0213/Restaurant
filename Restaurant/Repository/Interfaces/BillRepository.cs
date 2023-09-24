using Restaurant.Data;
using Restaurant.Models;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Repository
{
    public class BillRepository : IBillRepository
    {
        private readonly RestaurantContext _context;

        public BillRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool BillExists(int id)
        {
            return _context.Bills.Any(b => b.Id == id);
        }

        public bool createBill(Bill bill)
        {
            try
            {
                _context.Bills.Add(bill);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool deleteBill(int id)
        {
            var billToDelete = _context.Bills.Where(b => b.Id == id).FirstOrDefault();
            if (billToDelete == null)
            {
                return false;
            }

            try
            {
                _context.Bills.Remove(billToDelete);
                _context.SaveChanges();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public Bill GetBillByBillDate(DateTime BillDate)
        {
            return _context.Bills.Where(b => b.BillDate == BillDate).FirstOrDefault();
        }

        public Bill GetBillByDiscountAmount(decimal DiscountAmount)
        {
            return _context.Bills.Where(b => b.DiscountAmount == DiscountAmount).FirstOrDefault();
        }

        public Bill GetBillByTotalAmount(decimal TotalAmount)
        {
            return _context.Bills.Where(b => b.TotalAmount == TotalAmount).FirstOrDefault();
        }

        public Bill GetBillId(int id)
        {
            return _context.Bills.Where(b => b.Id == id).FirstOrDefault();
        }

        public ICollection<Bill> GetBills()
        {
            return _context.Bills.OrderBy(b => b.Id).ToList();
        }

        public ICollection<Bill> GetBillsByBillDate(DateTime billDate)
        {
            return _context.Bills.Where(b => b.BillDate.Date == billDate.Date).ToList();
        }

        public ICollection<Bill> GetBillsByCustomerId(int customerId)
        {
            return _context.Bills.Where(b => b.CustomerId == customerId).ToList();
        }

        //public ICollection<Bill> GetBillsByCustomerName(string customerName)
        //{
        //    return _context.Bills.Where(b => b.User.Name == customerName).ToList();
        //}

        public ICollection<Bill> GetBillsByOrderId(int orderId)
        {
            return _context.Bills.Where(b => b.OrderId == orderId).ToList();
        }

        public ICollection<Bill> GetBillsByPromotionId(int promotionId)
        {
            return _context.Bills.Where(b => b.PromotionId == promotionId).ToList();
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool updateBill(Bill bill)
        {
            try
            {
                var billToUpdate = _context.Bills.Where(b => b.Id == bill.Id).FirstOrDefault();

                if (billToUpdate != null)
                {
                    billToUpdate.BillDate = bill.BillDate;
                    billToUpdate.TotalAmount = bill.TotalAmount;
                    billToUpdate.DiscountAmount = bill.DiscountAmount;
                    billToUpdate.CustomerId = bill.CustomerId;
                    billToUpdate.PromotionId = bill.PromotionId;
                    billToUpdate.OrderId = bill.OrderId;

                    _context.SaveChanges();

                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                return false;
            }

        }
    }
}
