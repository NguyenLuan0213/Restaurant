namespace Restaurant.Dto
{
    public class OrderDTO
    {
        public int Id { get; set; }

        public Guid CashierId { get; set; }

        public int TableId { get; set; }

        public DateTime OrderTime { get; set; }

        public string Status { get; set; } = null!;

        public decimal? TotalPrice { get; set; }

    }
}
