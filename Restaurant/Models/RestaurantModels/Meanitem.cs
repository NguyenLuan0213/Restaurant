﻿using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public class Meanitem
{
    public int Id { get; set; }

    public int MeanId { get; set; }

    public int MenuItemId { get; set; }

    public int? Quantity { get; set; }

    public decimal? TotalPrice { get; set; }

    public virtual Mean Mean { get; set; } = null!;

    public virtual Menuitem MenuItem { get; set; } = null!;
}
