using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class MeanItemRepository : IMeanItemRepository
    {
        private readonly RestaurantContext _context;

        public MeanItemRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool CreateMeanIteam(Meanitem meanitem)
        {
            try
            {
                var menuItem = _context.Menuitems.FirstOrDefault(m => m.Id == meanitem.MenuItemId);
                if (menuItem != null)
                {
                    meanitem.TotalPrice = meanitem.Quantity * menuItem.Price;
                }
                else
                {
                    // Xử lý khi không tìm thấy menuItem
                    // Có thể gán TotalPrice = 0 hoặc xử lý khác tùy theo nhu cầu của bạn
                }

                _context.Meanitems.Add(meanitem);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteMeanIteam(int id)
        {
            var meanItemToDelete = _context.Meanitems.FirstOrDefault(m => m.Id == id);
            if (meanItemToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Meanitems.Remove(meanItemToDelete);
                _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                return true; // Trả về true nếu xóa thành công
            }

            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public Meanitem GetMeanIteamById(int id)
        {
            return _context.Meanitems.Where(m => m.Id == id).FirstOrDefault();
        }

        public ICollection<Meanitem> GetMeanIteamByMeanId(int meanId)
        {
            return _context.Meanitems.Where(m => m.MeanId == meanId).ToList();
        }

        public ICollection<Meanitem> GetMeanIteams()
        {
            return _context.Meanitems.OrderBy(m => m.Id).ToList();
        }

        public Menuitem GetMenuItemById(int menuItemId)
        {
            return _context.Menuitems.FirstOrDefault(m => m.Id == menuItemId);
        }

        public Meanitem GetMeanitemByMenuItemId(int menuItemId)
        {
            return _context.Meanitems.Where(m => m.MenuItemId == menuItemId).FirstOrDefault();
        }

        public bool MeanIteamExists(int id)
        {
            return _context.Meanitems.Any(m => m.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool UpdateMeanIteam(Meanitem meanitem)
        {
            try
            {
                var resultMeanitem = _context.Meanitems.FirstOrDefault(r => r.Id == meanitem.Id);

                if (resultMeanitem != null)
                {
                    resultMeanitem.MeanId = meanitem.MeanId;
                    resultMeanitem.MenuItemId = meanitem.MenuItemId;
                    resultMeanitem.Quantity = meanitem.Quantity;

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
