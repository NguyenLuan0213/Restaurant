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

        public User GetUserByUserName(string userName)
        {
            return _context.Users.FirstOrDefault(u => u.UserName == userName);
        }
    }
}
