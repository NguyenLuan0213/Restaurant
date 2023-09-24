using System.ComponentModel.DataAnnotations.Schema;

namespace Restaurant.Models
{
    public class ServiceInfo
    {
        [NotMapped]
        public string ServiceName { get; set; }
        [NotMapped]
        public string ServiceUrl { get; set; }
    }
}
