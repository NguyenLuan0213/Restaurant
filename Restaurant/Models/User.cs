using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models;

public partial class User
{
    [Key]
    public int Id { get; set; }

    public string? Username { get; set; }

    public string? Password { get; set; }
    public string? Email { get; set; }

    public string Fullname { get; set; } = null!;

    public string Phone { get; set; } = null!;

    public string Address { get; set; } = null!;

    public string Roles { get; set; } = null!;

    public string? Image { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual ICollection<Comment> Comments { get; set; } = new List<Comment>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<Table> Tables { get; set; } = new List<Table>();

    [NotMapped]
    public byte[] PasswordHash { get; set; }
    [NotMapped]
    public byte[] PasswordSalt { get; set; }

}
