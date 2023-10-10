using System.ComponentModel.DataAnnotations;

namespace Restaurant.Models.SignUp
{
    public class RegisterUser
    {
        [Required(ErrorMessage = "User Name is required")]
        public string? Username { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "Email is required")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        public string? Password { get; set; }

        [Required(ErrorMessage = "Phone Number is required")]
        public string? PhoneNumber { get; set; }

        public string? Address { get; set; }

        [Required(ErrorMessage = "Fullname is required")]
        public string? Fullname { get; set; }
        [Required(ErrorMessage = "Birthday is required")]
        public string? BirthDay { get; set; }
        public string? Gender { get; set; }

        public string? Image { get; set; }

        [Required(ErrorMessage = "Roles is required")]
        public string? Roles { get; set; }
    }
}
