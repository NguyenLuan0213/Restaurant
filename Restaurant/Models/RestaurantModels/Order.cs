using Restaurant.Models.Users;
using System.Text.Json.Serialization;

namespace Restaurant.Models.RestaurantModels;

public class Order
{
    public int Id { get; set; }

    public Guid? CashierId { get; set; }

    public Guid? CustomerId { get; set; }

    public int? TableId { get; set; }

    public DateTime OrderTime { get; set; }

    public string Status { get; set; } = null!;

    public decimal? TotalPrice { get; set; }

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public Mean? Means { get; set; }
    [JsonIgnore]
    public virtual User? Cashier { get; set; }
    [JsonIgnore]
    public virtual User? Customer { get; set; }

    public virtual Table Table { get; set; } = null!;
}
