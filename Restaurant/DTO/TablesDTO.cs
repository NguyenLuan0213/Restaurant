namespace Restaurant.Dto
{
    public class TablesDTO
    {
        public int Id { get; set; }

        public int RestaurantId { get; set; }

        public int TableNumber { get; set; }

        public int Seats { get; set; }

        public string Status { get; set; } = null!;

        public int IdWaiter { get; set; }
    }
}
