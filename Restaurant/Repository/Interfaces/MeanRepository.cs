using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class MeanRepository : IMeanRepository
    {
        private readonly RestaurantContext _context;

        public MeanRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool UpdateMean(Mean mean)
        {
            try
            {
                var existingMean = _context.Means.FirstOrDefault(r => r.Id == mean.Id);

                if (existingMean != null)
                {
                    //existingMean.OrderId = mean.OrderId;
                    existingMean.Description = mean.Description;

                    // Lấy danh sách MeanItem có cùng meanId
                    var meanItems = _context.Meanitems.Where(item => item.MeanId == mean.Id).ToList();

                    // Tính tổng totalPrice của các MeanItem
                    decimal? totalPrice = meanItems.Sum(item => item.TotalPrice);

                    // Cập nhật giá trị totalPrice của Mean
                    existingMean.TotalPrice = totalPrice;

                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    return true; // Trả về true nếu cập nhật thành công
                }
                return false; // Trả về false nếu không tìm thấy Mean cần cập nhật
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public bool CreateMean(Mean mean)
        {
            try
            {
                _context.Means.Add(mean);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteMean(int id)
        {
            var meanToDelete = _context.Means.FirstOrDefault(m => m.Id == id);
            if (meanToDelete == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Means.Remove(meanToDelete);
                _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                return true; // Trả về true nếu xóa thành công
            }

            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public Mean GetMeanById(int id)
        {
            return _context.Means.Where(m => m.Id == id).FirstOrDefault();
        }

        public ICollection<Mean> GetMeanByMeanItem(int id)
        {
            return _context.Means.Where(m => m.Id == id).ToList();
        }

        public ICollection<Mean> GetMeans()
        {
            return _context.Means.OrderBy(m => m.Id).ToList();
        }

        public bool MeanExists(int id)
        {
            return _context.Means.Any(m => m.Id == id);
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

       

        //ICollection<Mean> IMeanRepository.GetMeanByOrderId(int orderId)
        //{
        //    return _context.Means.Where(m => m.OrderId == orderId).ToList();
        //}

    }
}
