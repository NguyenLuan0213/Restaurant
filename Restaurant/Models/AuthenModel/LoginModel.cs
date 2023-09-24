using System.ComponentModel.DataAnnotations;

namespace Restaurant.Models.AuthenModel
{
    public class LoginModel
    {
        [Required]
        [MaxLength(50)]
        public string Username { get; set; } = null!;
        [Required]
        [MaxLength(250)]
        public string Password { get; set; } = null!;
    }
}
