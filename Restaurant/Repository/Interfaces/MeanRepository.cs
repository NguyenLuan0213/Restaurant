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

        public bool UpdateMean(Mean mean)
        {
            try
            {
                var resultMeans = _context.Means.FirstOrDefault(r => r.Id == mean.Id);

                if (resultMeans != null)
                {
                    resultMeans.OrderId = mean.OrderId;
                    resultMeans.Description = mean.Description;

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

        ICollection<Mean> IMeanRepository.GetMeanByOrderId(int orderId)
        {
            return _context.Means.Where(m => m.OrderId == orderId).ToList();
        }
    }
}
