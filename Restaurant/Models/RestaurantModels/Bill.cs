using Restaurant.Models.Users;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Restaurant.Models.RestaurantModels;

public class Bill
{
    [Key]
    public int Id { get; set; }

    public int OrderId { get; set; }

    public DateTime BillDate { get; set; }

    public decimal? TotalAmount { get; set; }

    public decimal? DiscountAmount { get; set; }

    public Guid? CustomerId { get; set; }

    public int? PromotionId { get; set; }

    public virtual User? Customer { get; set; }

    public virtual Order Order { get; set; } = null!;

    public virtual Promotion? Promotion { get; set; }
}
