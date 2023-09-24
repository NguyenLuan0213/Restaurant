using System;
using System.Collections.Generic;

namespace Restaurant.Models;

public partial class Order
{
    public int Id { get; set; }

    public int CashierId { get; set; }

    public int TableId { get; set; }

    public DateTime OrderTime { get; set; }

    public string Status { get; set; } = null!;

    public virtual ICollection<Bill> Bills { get; set; } = new List<Bill>();

    public virtual User Cashier { get; set; } = null!;

    public virtual ICollection<Mean> Means { get; set; } = new List<Mean>();

    public virtual Table Table { get; set; } = null!;
}
