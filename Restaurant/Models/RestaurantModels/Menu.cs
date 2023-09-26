using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public partial class Menu
{
    public int Id { get; set; }

    public int RestaurantId { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public virtual ICollection<Menuitem> Menuitems { get; set; } = new List<Menuitem>();

    public virtual Restaurantsbr Restaurant { get; set; } = null!;
}
