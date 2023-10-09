namespace Restaurant.Service
{
    public interface IOrderService
    {
        Task CheckAndUpdateOrderStatusAsync();
    }
}
