using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class MenuItemRepository : IMenuItemRepository
    {
        private readonly RestaurantContext _context;

        public MenuItemRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool CreateMenuItem(Menuitem menuitem)
        {
            try
            {
                _context.Menuitems.Add(menuitem);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteMenuItem(int id)
        {
            var menuItemToDelete = _context.Menuitems.FirstOrDefault(m => m.Id == id);
            if (menuItemToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Menuitems.Remove(menuItemToDelete);
                _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                return true; // Trả về true nếu xóa thành công
            }

            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public Menuitem GetMenuItemByDescription(string Description)
        {
            return _context.Menuitems.Where(p => p.Description == Description).FirstOrDefault();
        }

        public Menuitem GetMenuItemById(int id)
        {
            return _context.Menuitems.Where(p => p.Id == id).FirstOrDefault();
        }

        public ICollection<Menuitem> GetMenuItemByMenu(int MenuId)
        {
            return _context.Menuitems.Where(p => p.MenuId == MenuId).ToList();
        }

        public Menuitem GetMenuItemByName(string Name)
        {
            return _context.Menuitems.Where(p => p.Name == Name).FirstOrDefault();
        }

        public ICollection<Menuitem> GetMenuItemByNameItem(string Name)
        {
            return _context.Menuitems.Where(p => p.Name.Contains(Name)).ToList();
        }

        public Menuitem GetMenuItemByPrice(decimal Price)
        {
            return _context.Menuitems.Where(p => p.Price == Price).FirstOrDefault();
        }

        public ICollection<Menuitem> GetMenuItems()
        {
            return _context.Menuitems.OrderBy(p => p.Id).ToList();
        }

        public bool MenuItemExists(int id)
        {
            return _context.Menuitems.Any(p => p.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool UpdateMenuItem(Menuitem menuitem)
        {
            try
            {
                var resultMenuItem = _context.Menuitems.FirstOrDefault(r => r.Id == menuitem.Id);

                if (resultMenuItem != null)
                {
                    resultMenuItem.Name = menuitem.Name;
                    resultMenuItem.Price = menuitem.Price;
                    resultMenuItem.MenuId = menuitem.MenuId;
                    resultMenuItem.Description = menuitem.Description;
                    //resultMenuItem.Img = menuitem.Img;

                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    return true; // Trả về true nếu cập nhật thành công
                }
                else
                {
                    return false; // Trả về false nếu không tìm thấy nhà hàng
                }
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }
    }
}
