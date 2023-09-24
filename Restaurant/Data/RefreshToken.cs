using Restaurant.Models;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Data
{
    public class RefreshToken
    {
        [Key]
        public Guid Id { get; set; }
        public int UserId { get; set; }
        [ForeignKey(nameof(UserId))]
        public User User { get; set; } = null!;
        public string Token { get; set; } = null!;
        public string JwtId { get; set; } = null!;
        public bool IsUsed { get; set; }
        public bool IsLocked { get; set; }
        public DateTime ExpiredDate { get; set; }
        public DateTime IssuedAt { get; set; }
    }
}
