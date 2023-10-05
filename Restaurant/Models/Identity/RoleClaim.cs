using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models.Identity

{
    public class RoleClaim : IdentityRoleClaim<Guid>
    {
        public virtual Role Roles { get; set; }
    }
}