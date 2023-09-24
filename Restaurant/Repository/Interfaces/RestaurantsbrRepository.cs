using Restaurant.Data;
using Restaurant.Models;
using System.Xml.Linq;

namespace Restaurant.Repository.Interfaces
{
    public class RestaurantsbrRepository : IRestaurantsbrRepository
    {
        private readonly RestaurantContext _context;

        public RestaurantsbrRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool CreateRestaurantsbr(Restaurantsbr restaurantsbr)
        {
            try
            {
                _context.Restaurantsbrs.Add(restaurantsbr);
                return Save(); // Gọi hàm Save để lưu thay đổi và trả về kết quả
            }
            catch (Exception)
            {
                // Xử lý lỗi tại đây nếu cần thiết, ví dụ: ghi log hoặc trả về false
                return false;
            }
        }

        public Restaurantsbr GetRestaurantsbr(int id)
        {
            return _context.Restaurantsbrs.Where(r => r.Id == id).FirstOrDefault();
        }

        public Restaurantsbr GetRestaurantsbr(string name)
        {
            return _context.Restaurantsbrs.Where(r => r.Name == name).FirstOrDefault();
        }

        public Restaurantsbr GetRestaurantsbrByAddress(string address)
        {
            return _context.Restaurantsbrs.Where(r => r.Address == address).FirstOrDefault();
        }

        public Restaurantsbr GetRestaurantsbrByDescription(string description)
        {
            return _context.Restaurantsbrs.Where(r => r.Description == description).FirstOrDefault();
        }

        public ICollection<Restaurantsbr> GetRestaurantsbrs()
        {
            return _context.Restaurantsbrs.OrderBy(r => r.Id).ToList();
        }

        public bool RestaurantsbrExists(int id)
        {
            return _context.Restaurantsbrs.Any(r => r.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool DeleteRestaurantsbr(int id)
        {
            var restaurantToDelete = _context.Restaurantsbrs.FirstOrDefault(r => r.Id == id);
            if (restaurantToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Restaurantsbrs.Remove(restaurantToDelete);
                _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                return true; // Trả về true nếu xóa thành công
            }

            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public bool UpdateRestaurantsbr(Restaurantsbr restaurantsbr)
        {
            try
            {
                var resultRestaurant = _context.Restaurantsbrs.FirstOrDefault(r => r.Id == restaurantsbr.Id);

                if (resultRestaurant != null)
                {
                    resultRestaurant.Name = restaurantsbr.Name;
                    resultRestaurant.Address = restaurantsbr.Address;
                    resultRestaurant.Description = restaurantsbr.Description;

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
