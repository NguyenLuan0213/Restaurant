namespace Restaurant.Dto
{
    public class MenuItemDTO
    {
        public int Id { get; set; }

        public int MenuId { get; set; }

        public string Name { get; set; } = null!;

        public string? Description { get; set; } = null!;

        public decimal Price { get; set; }

        public string? Image { get; set; }

        public int? RestaurantId { get; set; }

        public IFormFile? File { get; set; }
    }
}
