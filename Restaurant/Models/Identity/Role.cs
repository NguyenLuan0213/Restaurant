
using Microsoft.AspNetCore.Identity;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Identity;

public class Role : IdentityRole<Guid>
{

    public virtual ICollection<UserRole> UserRoles { get; set; }
    public virtual ICollection<RoleClaim> RoleClaims { get; set; }
}
