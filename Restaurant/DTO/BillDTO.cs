namespace Restaurant.Dto
{
    public class BillDTO
    {
        public int Id { get; set; }

        public int OrderId { get; set; }

        public DateTime BillDate { get; set; }

        public decimal? TotalAmount { get; set; }

        public decimal? DiscountAmount { get; set; } 

        public Guid? CustomerId { get; set; }

        public int? PromotionId { get; set; }
    }
}
