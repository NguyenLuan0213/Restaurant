using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Dto
{
    public class CommentDTO
    {
        public int Id { get; set; }

        public Guid CustomerId { get; set; }

        public int RestaurantId { get; set; }

        public int Rating { get; set; }

        public string ReviewText { get; set; }
        public DateOnly CommentDate { get; set; }

    }
}
