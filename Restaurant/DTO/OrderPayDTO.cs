using Restaurant.Dto;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;

namespace Restaurant.DTO
{
    public class OrderPayDTO
    {
        public decimal? TotalPrice;

        public string? name { get; set; } 
        public OrderDTO? orderDTO { get; set; }

        public User? Customer { get; set; } = null!;
    }
}
