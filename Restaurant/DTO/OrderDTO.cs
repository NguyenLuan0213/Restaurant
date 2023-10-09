using Restaurant.DTO;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Dto
{
    public class OrderDTO
    {
        public int Id { get; set; }

        public Guid? CashierId { get; set; }

        public Guid? CustomerId { get; set; }

        public int TableId { get; set; }

        public DateTime OrderTime { get; set; }

        public string Status { get; set; } = null!;

        public decimal? TotalPrice { get; set; }

        public List<MeanItemDTO> MeanItems { get; set; }
        public UsersDTO Customer { get; set; } = null!;

        public TablesDTO Tables { get; set; } = null!;
    }
}
