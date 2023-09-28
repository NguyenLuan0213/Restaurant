using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface IMeanItemRepository
    {
        ICollection<Meanitem> GetMeanIteams();
        Meanitem GetMeanIteamById(int id);
        Meanitem GetMeanitemByMenuItemId(int menuItemId);
        ICollection<Meanitem> GetMeanIteamByMeanId(int meanId);

        public Menuitem GetMenuItemById(int menuItemId);

        bool CreateMeanIteam(Meanitem meanitem);
        bool UpdateMeanIteam(Meanitem meanitem);
        bool DeleteMeanIteam(int id);
        bool Save();
        bool MeanIteamExists(int id);
    }
}
