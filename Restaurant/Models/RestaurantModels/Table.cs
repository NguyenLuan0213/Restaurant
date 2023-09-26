using System;
using System.Collections.Generic;
using Restaurant.Models.Users;

namespace Restaurant.Models.RestaurantModels;

public partial class Table
{
    public int Id { get; set; }

    public int RestaurantId { get; set; }

    public int TableNumber { get; set; }

    public int Seats { get; set; }

    public string Status { get; set; } = null!;

    public int IdWaiter { get; set; }

    public virtual User IdWaiterNavigation { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual Restaurantsbr Restaurant { get; set; } = null!;
}
