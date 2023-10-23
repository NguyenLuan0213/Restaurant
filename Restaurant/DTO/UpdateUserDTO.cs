using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.DTO
{
    public class UpdateUserDTO
    {
        public Guid Id { get; set; }

        public string? Email { get; set; }

        public string? Fullname { get; set; }

        public string? PhoneNumber { get; set; }

        public string? Address { get; set; }

        public string? Gender { get; set; }

        public string? Roles { get; set; }

        public string? Birthday { get; set; }

        public string? Image { get; set; }

        public IFormFile? File { get; set; }
    }
}
