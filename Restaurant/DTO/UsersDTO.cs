﻿using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.DTO
{
    public class UsersDTO
    {
        public Guid Id { get; set; }
        public string? Username { get; set; }

        public string? Password { get; set; }

        public string? Email { get; set; }

        public string? Fullname { get; set; }

        public string? PhoneNumber { get; set; }

        public string? Address { get; set; }

        public string Roles { get; set; }
        [NotMapped]
        public string? Image { get; set; }
    }
}
