namespace Restaurant.Dto
{
    public class MenuDTO
    {
        public int Id { get; set; }
        public int RestaurantId { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
    }
}
