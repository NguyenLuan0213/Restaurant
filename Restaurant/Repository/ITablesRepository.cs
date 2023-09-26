using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository
{
    public interface ITablesRepository
    {
        ICollection<Table> GetTables();
        Table GetTable(int id);
        Table GetTableByNumber(int TableNumber);
        Table GetTableBySeats(int seats);
        Table GetTableByStatus(string status);
        Table GetTableByWaiterId(int waiterId);
        ICollection<Table> GetTablesByRestaurantId(int restaurantId);
        ICollection<Table> GetTablesByRestaurantIdAndStatus(int restaurantId, string status);
        bool CreateTable(Table table);
        bool UpdateTable(Table table);
        bool DeleteTable(int id);
        bool Save();
        bool TableExists(int id);

    }
}
