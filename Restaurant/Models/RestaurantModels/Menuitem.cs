using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public partial class Menuitem
{
    public int Id { get; set; }

    public int MenuId { get; set; }

    public string Name { get; set; } = null!;

    public string? Description { get; set; }

    public decimal Price { get; set; }

    public string? Image { get; set; }

    public virtual ICollection<Meanitem> Meanitems { get; set; } = new List<Meanitem>();

    public virtual Menu Menu { get; set; } = null!;
}
