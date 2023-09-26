using Restaurant.Data;
using Restaurant.Models.Users;

namespace Restaurant.Repository.Interfaces
{
    public class UsersRepository : IUsersRepository
    {
        private readonly RestaurantContext _context;

        public UsersRepository(RestaurantContext context)
        {
            _context = context;
        }

        public User GetUserById(int id)
        {
            return _context.Users.Where(u => u.Id == id).FirstOrDefault();
        }

        public User GetUserByEmail(string email)
        {
            return _context.Users.Where(u => u.Email == email).FirstOrDefault();
        }

        public User GetUserByFullname(string Fullname)
        {
            return _context.Users.Where(u => u.Fullname == Fullname).FirstOrDefault();
        }

        public User GetUserByPassword(string password)
        {
            return _context.Users.Where(u => u.Password == password).FirstOrDefault();
        }

        public User GetUserByPhoneNumber(string phoneNumber)
        {
            return _context.Users.Where(u => u.Phone == phoneNumber).FirstOrDefault();
        }

        public User GetUserByRole(string role)
        {
            return _context.Users.Where(u => u.Roles == role).FirstOrDefault();
        }

        public User GetUserByUserName(string userName)
        {
            return _context.Users.Where(u => u.UserName == userName).FirstOrDefault();
        }

        public ICollection<User> GetUsers()
        {
            return _context.Users.OrderBy(u => u.Id).ToList();
        }

        public ICollection<User> GetUsersByFullName(string fullname)
        {
            return _context.Users.Where(u => u.Fullname == fullname).ToList();
        }

        public ICollection<User> GetUsersByRole(string role)
        {
            return _context.Users.Where(u => u.Roles == role).ToList();
        }

        public bool UserExists(int id)
        {
            return _context.Users.Any(u => u.Id == id);
        }

        public bool CreateUser(User user)
        {
            try
            {
                _context.Users.Add(user);
                return Save(); // Gọi hàm Save để lưu thay đổi và trả về kết quả
            }
            catch (Exception)
            {
                // Xử lý lỗi tại đây nếu cần thiết, ví dụ: ghi log hoặc trả về false
                return false;
            }
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }


        public bool DeleteUser(int id)
        {
            var user = _context.Users.FirstOrDefault(u => u.Id == id);
            if (user == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }

            try
            {
                _context.Users.Remove(user);
                _context.SaveChanges();
                return true; // Xóa thành công
            }
            catch (Exception)
            {
                return false; // Xảy ra lỗi khi xóa
            }
        }

        public bool UpdateUser(User user)
        {
            try
            {
                var resultUser = _context.Users.FirstOrDefault(u => u.Id == user.Id);

                if (resultUser != null)
                {
                    resultUser.UserName = user.UserName;
                    resultUser.Password = user.Password;
                    resultUser.Email = user.Email;
                    resultUser.Fullname = user.Fullname;
                    resultUser.Phone = user.Phone;
                    resultUser.Address = user.Address;
                    resultUser.Roles = user.Roles;
                    resultUser.Image = user.Image;

                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu
                    return true; // Trả về true nếu cập nhật thành công
                }
                else
                {
                    return false; // Trả về false nếu không tìm thấy người dùng
                }
            }
            catch (Exception)
            {
                return false; // Xử lý lỗi và trả về false nếu có lỗi xảy ra
            }
        }

        public async Task<bool> UploadImageAsync(int userId, string imageUrl)
        {
            try
            {
                var user = _context.Users.FirstOrDefault(u => u.Id == userId);

                if (user != null)
                {
                    user.Image = imageUrl;
                    await _context.SaveChangesAsync();
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public async Task<string> GetImageUrlAsync(int userId)
        {
            try
            {
                var user = _context.Users.FirstOrDefault(u => u.Id == userId);
                return user?.Image;
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
