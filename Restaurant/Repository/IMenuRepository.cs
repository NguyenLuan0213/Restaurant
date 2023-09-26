using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface IMenuRepository
    {
        ICollection<Menu> GetMenus();
        Menu GetMenuId(int id);
        Menu GetMenuByName(string name);
        Menu GetMenuByDescription(string description);
        ICollection<Menu> GetMenuByRestaurantId(int restaurantId);
        bool CreateMenu(Menu menu);
        bool UpdateMenu(Menu menu);
        bool DeleteMenu(int id);
        bool Save();
        bool MenuExists(int id);
    }
}
