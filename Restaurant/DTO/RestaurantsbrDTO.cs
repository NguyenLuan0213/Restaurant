namespace Restaurant.Dto
{
    public class RestaurantsbrDTO
    {
        public int Id { get; set; }

        public string Name { get; set; } = null!;

        public string Address { get; set; }

        public string Description { get; set; }

        public string? Image { get; set; }
    }
}
