using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public class Promotion
{
    public int Id { get; set; }

    public int RestaurantId { get; set; }

    public string PromotionName { get; set; } = null!;

    public string? Description { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime EndDate { get; set; }

    public decimal Discount { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual Restaurantsbr Restaurant { get; set; } = null!;
}
