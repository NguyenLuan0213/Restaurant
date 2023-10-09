using Restaurant.Service;

namespace Restaurant.Threading
{
    public class OrderStatusUpdater
    {
        private readonly TimeSpan _interval;
        private Timer _timer;
        private IOrderService orderService;
        private TimeSpan timerInterval;
        private readonly IServiceProvider _serviceProvider; // Inject IServiceProvider

        public OrderStatusUpdater(TimeSpan interval, IServiceProvider serviceProvider)
        {
            _interval = interval;
            _serviceProvider = serviceProvider;
        }

        public OrderStatusUpdater(TimeSpan timerInterval, IOrderService orderService)
        {
            this.timerInterval = timerInterval;
            this.orderService = orderService;
        }

        public void Start()
        {
            // Khởi tạo timer và đặt hàm xử lý vào phương thức kiểm tra
            _timer = new Timer(CheckAndUpdateOrderStatus, null, TimeSpan.Zero, _interval);
        }

        private void CheckAndUpdateOrderStatus(object state)
        {
            // Sử dụng IServiceProvider để lấy IOrderService
            using (var scope = _serviceProvider.CreateScope())
            {
                var orderService = scope.ServiceProvider.GetRequiredService<IOrderService>();
                orderService.CheckAndUpdateOrderStatusAsync().Wait();
            }
        }
    }
}