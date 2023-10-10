namespace Restaurant.DTO
{
    public class CommentForCustomerDTO
    {
        public int Id { get; set; }

        public Guid CustomerId { get; set; }

        public int RestaurantId { get; set; }

        public int Rating { get; set; }

        public string ReviewText { get; set; }

        public DateOnly CommentDate { get; set; }

        public string CustomerName { get; set; }

        public string CustomerImage { get; set; }
    }
}