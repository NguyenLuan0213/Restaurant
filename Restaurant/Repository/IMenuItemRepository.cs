using Restaurant.Models;

namespace Restaurant.Repository
{
    public interface IMenuItemRepository
    {
        ICollection<Menuitem> GetMenuItems();
        Menuitem GetMenuItemById(int id);
        Menuitem GetMenuItemByName(string Name);
        Menuitem GetMenuItemByDescription(string Description);
        Menuitem GetMenuItemByPrice(decimal Price);
        ICollection<Menuitem> GetMenuItemByMenu(int MenuId);
        ICollection<Menuitem> GetMenuItemByNameItem(string Name);
        bool CreateMenuItem(Menuitem menuitem);
        bool UpdateMenuItem(Menuitem menuitem);
        bool DeleteMenuItem(int id);
        bool Save();
        bool MenuItemExists(int id);

    }
}
