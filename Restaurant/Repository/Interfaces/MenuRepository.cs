using Restaurant.Data;
using Restaurant.Models;
using System.Xml.Linq;

namespace Restaurant.Repository.Interfaces
{
    public class MenuRepository : IMenuRepository
    {
        private readonly RestaurantContext _context;
        public MenuRepository(RestaurantContext context)
        {
            _context = context;
        }
        public Menu GetMenuId(int id)
        {
            return _context.Menus.Where(m => m.Id == id).FirstOrDefault();
        }
        public Menu GetMenuByName(string name)
        {
            return _context.Menus.Where(m => m.Name == name).FirstOrDefault();
        }
        public Menu GetMenuByDescription(string Description)
        {
            return _context.Menus.Where(m => m.Description == Description).FirstOrDefault();
        }
        public ICollection<Menu> GetMenus()
        {
            return _context.Menus.OrderBy(m => m.Id).ToList();
        }
        public bool MenuExists(int id)
        {
            return _context.Menus.Any(m => m.Id == id);
        }

        ICollection<Menu> IMenuRepository.GetMenuByRestaurantId(int restaurantId)
        {
            return _context.Menus.Where(m => m.RestaurantId == restaurantId).ToList();
        }

        public bool CreateMenu(Menu menu)
        {
            try
            {
                _context.Menus.Add(menu);
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

        public bool UpdateMenu(Menu menu)
        {
            try
            {
                var resultMenu = _context.Menus.FirstOrDefault(r => r.Id == menu.Id);

                if (resultMenu != null)
                {
                    resultMenu.Name = menu.Name;
                    resultMenu.RestaurantId = menu.RestaurantId;
                    resultMenu.Description = menu.Description;

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

        public bool DeleteMenu(int id)
        {
            var menuToDelete = _context.Menus.FirstOrDefault(m => m.Id == id);
            if (menuToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Menus.Remove(menuToDelete);
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
