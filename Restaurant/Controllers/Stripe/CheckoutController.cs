using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
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

    [HttpPost("create-checkout-session")]
    public IActionResult CreateSession([FromBody] OrderDTO orderDTO)
    {
        decimal amount = orderDTO.TotalPrice ?? 0.0m;
        try
        { 
        var options = new SessionCreateOptions
        {
            PaymentMethodTypes = new List<string>
            {
                "card",
            },
            LineItems = new List<SessionLineItemOptions>
            {
                new SessionLineItemOptions
                {
                    PriceData = new SessionLineItemPriceDataOptions
                    {
                        UnitAmount =(long?)amount,
                        Currency = "VND",
                        ProductData = new SessionLineItemPriceDataProductDataOptions
                        {
                            Name = orderDTO.Id.ToString(),
                        },
                    },
                    Quantity = 1,
                },
            },
            Mode = "payment",
            SuccessUrl = "https://example.com/success",
            CancelUrl = "https://example.com/cancel",
        };  
        var service = new SessionService();
        Session session = service.Create(options);
        return new JsonResult(
                new
                {
                    sessionId = session.Id,
                    url = session.Url,

                });
        }
        catch (StripeException e)
        {
            return new JsonResult(new { error = e.Message });
        }

    }

    [HttpPost("checkout")]
    public IActionResult CreatePaymentIntent([FromBody] OrderDTO orderDTO)
    {
        System.Diagnostics.Debug.WriteLine("nó có vào hàm thanh toán");

        decimal amount = orderDTO.TotalPrice ?? 0.0m;
        var productsPost = new List<object>();

        try
        {
            StripeConfiguration.ApiKey = "sk_test_51Mm6CAJTSCX72rEN0osGovCVaSKimGjDCkJjqJmA4vxPFvOav5pfxsJwuaNsm2GQOObTWTsiyY5zPog6FIrVBSgf00zDD66h8d";

            var options = new PaymentIntentCreateOptions
            {
                Amount = (long?)amount, // Convert to cents
                Currency = "vnd",
                PaymentMethodTypes = new List<string> { "card" },
                Metadata = new Dictionary<string, string>
                   {
                       { "customer_name", orderDTO.Id.ToString() ?? "" },
                       { "customer_phone", orderDTO.Id.ToString() ?? "" },
                       { "customer_address", orderDTO.Id.ToString() ?? "" },
                   },
                PaymentMethodOptions = new PaymentIntentPaymentMethodOptionsOptions
                {
                    Card = new PaymentIntentPaymentMethodOptionsCardOptions
                    {
                        RequestThreeDSecure = "automatic"
                    }
                }
            };

            var service = new PaymentIntentService();
            var intent = service.Create(options);

            return new JsonResult(
                new { 
                    client_secret = intent.ClientSecret,
                });
        }
        catch (StripeException e)
        {
            return new JsonResult(new { error = e.Message });
        }
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