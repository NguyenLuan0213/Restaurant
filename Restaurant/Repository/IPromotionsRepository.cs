using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface IPromotionsRepository
    {
        ICollection<Promotion> GetPromotions();
        Promotion GetPromotionId(int id);
        Promotion GetPromotionByName(string PromotionName);
        Promotion GetPromotionByDescription(string Description);
        Promotion GetPromotionByStartDate(DateTime StartDate);
        Promotion GetPromotionByEndDate(DateTime EndDate);
        Promotion GetPromotionByDiscount(decimal Discount);
        ICollection<Promotion> GetPromotionByRestaurantId(int restauranID);
        bool CreatePromotion(Promotion promotion);
        bool UpdatePromotion(Promotion promotion);
        bool DeletePromotion(int id);
        bool Save();
        bool PromotionExists(int id);
    }
}
