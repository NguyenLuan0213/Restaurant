using Microsoft.AspNetCore.Identity;
using Restaurant.Models.Users;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Identity
{
    public class UserToken : IdentityUserToken<Guid>
    {
        public virtual User User { get; set; }
    }
}