using Microsoft.AspNetCore.Identity;
using Restaurant.Models.Users;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Identity
{
    public class UserLogin : IdentityUserLogin<Guid>
    {
        public virtual User User { get; set; }
    }
}