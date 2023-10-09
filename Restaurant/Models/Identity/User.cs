using Microsoft.AspNetCore.Identity;
using Restaurant.Models.Identity;
using Restaurant.Models.RestaurantModels;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Users;

public class User : IdentityUser<Guid>
{
    public string? Password { get; set; }
    public string? Email { get; set; }
    public string? Gender { get; set; }
    public string? Fullname { get; set; } 
    public DateOnly? BrithDay { get; set; }
    public string? PhoneNumber { get; set; }
    public string? Address { get; set; } 
    public string? Image { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public ICollection<Order> CustomerOrders { get; set; } = new List<Order>();
    public ICollection<Order> CashierOrders { get; set; } = new List<Order>();

    public virtual ICollection<Table> Tables { get; set; } = new List<Table>();


    public virtual ICollection<UserClaim> Claims { get; set; }
    public virtual ICollection<UserLogin> Logins { get; set; }
    public virtual ICollection<UserToken> Tokens { get; set; }
    public virtual ICollection<UserRole> UserRoles { get; set; }


}
