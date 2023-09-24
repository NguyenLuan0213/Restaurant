namespace Restaurant.Models.AuthenModel
{
    public class TokenModel
    {
        public string AccessToken { get; set; } = null!;

        public string RefreshToken { get; set; } = null!;
    }
}
