using Restaurant.Models.Users;
using System;
using System.Collections.Generic;

namespace Restaurant.Models.RestaurantModels;

public class Comment
{
    public int Id { get; set; }

    public Guid CustomerId { get; set; }

    public int RestaurantId { get; set; }

    public int Rating { get; set; }

    public string? ReviewText { get; set; }

    public DateOnly CommentDate { get; set; }

    public virtual User Customer { get; set; } = null!;

    public virtual Restaurantsbr Restaurant { get; set; } = null!;
}
