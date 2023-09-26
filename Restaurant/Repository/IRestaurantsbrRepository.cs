using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface IRestaurantsbrRepository
    {
        ICollection<Restaurantsbr> GetRestaurantsbrs();
        Restaurantsbr GetRestaurantsbr(int id);
        Restaurantsbr GetRestaurantsbr(string name);
        Restaurantsbr GetRestaurantsbrByAddress(string address);
        Restaurantsbr GetRestaurantsbrByDescription(string description);
        bool CreateRestaurantsbr(Restaurantsbr restaurantsbr);
        bool RestaurantsbrExists(int id);
        bool UpdateRestaurantsbr(Restaurantsbr restaurantsbr);
        bool DeleteRestaurantsbr(int id);
        bool Save();


    }
}
