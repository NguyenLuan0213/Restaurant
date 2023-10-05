using Microsoft.AspNetCore.Identity;
using Restaurant.Models.Users;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Identity
{
    public class UserRole : IdentityUserRole<Guid>
    {
        public virtual User User { get; set; }
        public virtual Role Roles { get; set; }
    }
}
