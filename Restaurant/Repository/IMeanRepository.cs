using Restaurant.Models;

namespace Restaurant.Repository
{
    public interface IMeanRepository
    {
        ICollection<Mean> GetMeans();
        Mean GetMeanById(int id);
        ICollection<Mean> GetMeanByMeanItem(int id);
        ICollection<Mean> GetMeanByOrderId(int orderId);
        bool CreateMean(Mean mean);
        bool UpdateMean(Mean mean);
        bool DeleteMean(int id);
        bool Save();
        bool MeanExists(int id);
    }
}
