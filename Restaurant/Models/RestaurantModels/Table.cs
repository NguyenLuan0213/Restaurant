using Restaurant.Models.Users;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace Restaurant.Models.RestaurantModels;

public class Table
{
    public int Id { get; set; }

    public int RestaurantId { get; set; }

    public int TableNumber { get; set; }

    public int Seats { get; set; }

    public string Status { get; set; } = null!;

    public Guid? IdWaiter { get; set; }

    [ForeignKey("IdWaiter")] // Chỉ định mối quan hệ khóa ngoại với IdWaiter
    public virtual User Waiter { get; set; } // Thêm thuộc tính để đại diện cho Waiter
    [JsonIgnore]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Restaurantsbr Restaurant { get; set; } = null!;
}
