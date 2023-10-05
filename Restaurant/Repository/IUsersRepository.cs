using Restaurant.Models.Users;

namespace Restaurant.Repository
{
    public interface IUsersRepository
    {
        //ICollection<User> GetUsers();
        //User GetUserByFullname(string Fullname);
        //User GetUserByEmail(string email);
        //User GetUserByPhoneNumber(string phoneNumber);
        User GetUserByUserName(string userName);
        //User GetUserByPassword(string password);
        //User GetUserByRole(string role);
        //ICollection<User> GetUsersByRole(string role);
        //ICollection<User> GetUsersByFullName(string fullname);

        //Task<bool> UploadImageAsync(int userId, string imageUrl);
        //Task<string> GetImageUrlAsync(int userId);

        //bool CreateUser(User user);
        //bool UpdateUser(User user);
        //bool DeleteUser(int id);
        //bool Save();
    }
}
