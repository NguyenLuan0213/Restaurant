namespace Restaurant.DTO
{
    public class MeanItemDTO
    {
        public int Id { get; set; }

        public int MeanId { get; set; }

        public int MenuItemId { get; set; }

        public int Quantity { get; set; }

        public decimal? TotalPrice { get; set; }


    }
}
