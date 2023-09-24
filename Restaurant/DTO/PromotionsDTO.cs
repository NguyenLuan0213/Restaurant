namespace Restaurant.Dto
{
    public class PromotionsDTO
    {
        public int Id { get; set; }
        public int RestaurantId { get; set; }
        public string PromotionName { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public decimal Discount { get; set; }
    }
}
