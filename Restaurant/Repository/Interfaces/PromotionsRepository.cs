using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class PromotionsRepository : IPromotionsRepository
    {
        private readonly RestaurantContext _context;
        public PromotionsRepository(RestaurantContext context)
        {
            _context = context;
        }
        public ICollection<Promotion> GetPromotions()
        {
            return _context.Promotions.OrderBy(p => p.Id).ToList();
        }
        public Promotion GetPromotionId(int id)
        {
            return _context.Promotions.Where(p => p.Id == id).FirstOrDefault();
        }
        public Promotion GetPromotionByName(string PromotionName)
        {
            return _context.Promotions.Where(p => p.PromotionName == PromotionName).FirstOrDefault();
        }
        public Promotion GetPromotionByDescription(string Description)
        {
            return _context.Promotions.Where(p => p.Description == Description).FirstOrDefault();
        }
        public Promotion GetPromotionByStartDate(DateTime StartDate)
        {
            return _context.Promotions.Where(p => p.StartDate == StartDate).FirstOrDefault();
        }
        public Promotion GetPromotionByEndDate(DateTime EndDate)
        {
            return _context.Promotions.Where(p => p.EndDate == EndDate).FirstOrDefault();
        }
        public Promotion GetPromotionByDiscount(decimal Discount)
        {
            return _context.Promotions.Where(p => p.Discount == Discount).FirstOrDefault();
        }
        public ICollection<Promotion> GetPromotionByRestaurantId(int restauranID)
        {
            return _context.Promotions.Where(p => p.RestaurantId == restauranID).ToList();
        }
        public bool PromotionExists(int id)
        {
            return _context.Promotions.Any(p => p.Id == id);
        }

        public bool CreatePromotion(Promotion promotion)
        {
            try
            {
                _context.Promotions.Add(promotion);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool UpdatePromotion(Promotion promotion)
        {
            try
            {
                var resultPromotion = _context.Promotions.FirstOrDefault(p => p.Id == promotion.Id);

                if (resultPromotion != null)
                {
                    resultPromotion.PromotionName = promotion.PromotionName;
                    resultPromotion.Description = promotion.Description;
                    resultPromotion.StartDate = promotion.StartDate;
                    resultPromotion.EndDate = promotion.EndDate;
                    resultPromotion.Discount = promotion.Discount;
                    resultPromotion.RestaurantId = promotion.RestaurantId;

                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    return true; // Trả về true nếu cập nhật thành công
                }

                return false; // Trả về false nếu không tìm thấy khuyến mãi
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public bool DeletePromotion(int id)
        {

            var promotionToDelete = _context.Promotions.FirstOrDefault(p => p.Id == id);
            if (promotionToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }
            try
            {
                _context.Promotions.Remove(promotionToDelete);
                _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                return true; // Trả về true nếu xóa thành công
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra

            }
        }
    }
}
