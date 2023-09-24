namespace Restaurant.Dto
{
    public class OrderDTO
    {
        public int Id { get; set; }

        public int CashierId { get; set; }

        public int TableId { get; set; }

        public DateTime OrderTime { get; set; }

        public string Status { get; set; } = null!;
    }
}
