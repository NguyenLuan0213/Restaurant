using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace Restaurant.Models.RestaurantModels;

public class Meanitem
{
    public int Id { get; set; }

    public int? MeanId { get; set; }

    public int MenuItemId { get; set; }

    public int? Quantity { get; set; }

    public decimal? TotalPrice { get; set; }
    [JsonIgnore]
    public virtual Mean? Mean { get; set; }

    public virtual Menuitem MenuItem { get; set; } = null!;
}
