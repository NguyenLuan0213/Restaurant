
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace Restaurant.Models.RestaurantModels;

public class Mean
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    public int Id { get; set; }

    public string? Description { get; set; }

    public decimal? TotalPrice { get; set; }

    public virtual ICollection<Meanitem> Meanitems { get; set; } = new List<Meanitem>();
    [JsonIgnore]
    public virtual Order Order { get; set; } = null!;
}
