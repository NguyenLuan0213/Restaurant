using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public partial class Mean
{
    public int Id { get; set; }

    public int? OrderId { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<Meanitem> Meanitems { get; set; } = new List<Meanitem>();

    public virtual Order? Order { get; set; }
}
