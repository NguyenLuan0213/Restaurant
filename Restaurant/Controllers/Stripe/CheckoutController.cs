using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Stripe;
using Stripe.Checkout;

namespace Restaurant.Controllers.Stripe;

[ApiController]
[Route("api/[controller]")]
public class CheckoutController : ControllerBase
{
    private readonly IConfiguration _configuration;

    private static string s_wasmClientURL = string.Empty;

    public CheckoutController(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    [HttpPost("create-payment-intent")]
    public IActionResult CreatePaymentIntent([FromBody] OrderDTO orderDTO)
    {
        decimal amount = orderDTO.TotalPrice ?? 0.0m;

        try
        {
            StripeConfiguration.ApiKey = "sk_test_51MlntRFtuguvBwBegX36MX391lBGHAE75zGQnaAt7HJUXi94ZTFAVUaiZUESK4c2TfhodRDNXXLGdc4CMrBS9FEN002Y7DiRvP";

            var paymentIntentService = new PaymentIntentService();
            var paymentIntent = paymentIntentService.Create(new PaymentIntentCreateOptions
            {
                Amount = (long?)amount,
                Currency = "VND",
                PaymentMethodTypes = new List<string> { "card" },
                // In the latest version of the API, specifying the `automatic_payment_methods` parameter is optional because Stripe enables its functionality by default.
                PaymentMethodOptions = new PaymentIntentPaymentMethodOptionsOptions
                {
                    Card = new PaymentIntentPaymentMethodOptionsCardOptions
                    {
                        RequestThreeDSecure = "automatic"
                    }
                }
            });

            return new JsonResult(new { clientSecret = paymentIntent.ClientSecret });
        }
        catch (StripeException e)
        {
            return new JsonResult(new { error = e.Message });
        }
    }

    [HttpGet("loadPubKey")]
    public IActionResult LoadPubKey()
    {
        // Trả về khóa bí mật
        return new JsonResult(new { pubKey = "pk_test_51MlntRFtuguvBwBePPJrdA6ZJ6CtY5Or5sJqf1vH8qi1eT7oyikE8pZSgS8o70aI8qgZeInyfEv00yvMveVMl7Xu00yJetHxZl" });
    }

    [HttpGet("success")]
    public ActionResult CheckoutSuccess(string sessionId)
    {
        var sessionService = new SessionService();
        var session = sessionService.Get(sessionId);

        // Here you can save order and customer details to your database.
        var total = session.AmountTotal.Value;
        var customerEmail = session.CustomerDetails.Email;

        return Redirect(s_wasmClientURL + "success");
    }
}