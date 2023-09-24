using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Restaurant.Data;
using Restaurant.Models;
using Restaurant.Models.AuthenModel;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Restaurant.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly RestaurantContext _context;
        private readonly AppSetting _appSettings;
        public AccountController(RestaurantContext context, IOptionsMonitor<AppSetting> optionsMonitor)
        {
            _context = context;
            _appSettings = optionsMonitor.CurrentValue;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register(RegisterModel model)
        {
            var user = await _context.Users.FirstOrDefaultAsync(p => p.Username == model.Username);
            if (user != null)
            {
                return Ok(new ApiResponse
                {
                    Status = false,
                    Message = "Username already exists"
                });
            }
            var newUser = new User
            {
                Fullname = model.FullName,
                Username = model.Username,
                Password = model.Password,
                Email = model.Email,
                Phone = model.Phone,
                Address = model.Address,
                Roles = "CUSTOMER"
            };
            await _context.AddAsync(newUser);
            await _context.SaveChangesAsync();
            return Ok(new ApiResponse
            {
                Status = true,
                Message = "Register success"
            });
        }

        [HttpPost("login")]
        public async Task <IActionResult> Validate(LoginModel model)
        {
            var user = _context.Users.SingleOrDefault(p => p.Username == model.Username && p.Password == model.Password);
            if (user == null)
            {
                return Ok(new ApiResponse
                {
                    Status = false,
                    Message = "Invalid username or password"
                });
            }

            var token = await GenerateToken(user);

            return Ok(new ApiResponse
            {
                Status = true,
                Message = "Authentication success",
                Data = token
            });
        }

        private async Task<TokenModel> GenerateToken(User user)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();

            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.Name, user.Fullname),
                    new Claim(JwtRegisteredClaimNames.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("UserName", user.Username),
                    new Claim("Id", user.Id.ToString()),
                    new Claim("Phone", user.Phone),
                    new Claim("Address", user.Address),

                    //roles
                    new Claim(ClaimTypes.Role, user.Roles),
                }),
                Expires = DateTime.UtcNow.AddHours(5),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = jwtTokenHandler.CreateToken(tokenDescription);
            var accessToken = jwtTokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();

            var refreshTokenEnttity = new RefreshToken
            {
                Id = Guid.NewGuid(),
                JwtId = token.Id,
                Token = refreshToken,
                UserId = user.Id,
                IsUsed = false,
                IsLocked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredDate = DateTime.UtcNow.AddHours(5)
            };

            await _context.AddAsync(refreshTokenEnttity);
            await _context.SaveChangesAsync();

            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };

        }

        private string GenerateRefreshToken()
        {
            var random = new Byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(random);
                return Convert.ToBase64String(random);
            }
        }

        [HttpPost("RenewToken")]
        public async Task<IActionResult> RenewToken(TokenModel model)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);
            var tokenValidateParam = new TokenValidationParameters
            {
                //tự cấp token
                ValidateIssuer = false,
                ValidateAudience = false,

                //ký vào token
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(secretKeyBytes),

                ClockSkew = TimeSpan.Zero,

                ValidateLifetime = false //ko kiểm tra token hết hạn
            };
            try
            {
                //check 1: AccessToken valid format
                var tokenInVerification = jwtTokenHandler.ValidateToken(model.AccessToken, tokenValidateParam, out var validatedToken);

                //check 2: Check alg
                if (validatedToken is JwtSecurityToken jwtSecurityToken)
                {
                    var result = jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase);
                    if (!result)//false
                    {
                        return Ok(new ApiResponse
                        {
                            Status = false,
                            Message = "Invalid token"
                        });
                    }
                }

                //check 3: Check accessToken expire?
                var utcExpireDate = long.Parse(tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Exp).Value);

                var expireDate = ConvertUnixTimeToDateTime(utcExpireDate);
                if (expireDate > DateTime.UtcNow)
                {
                    return Ok(new ApiResponse
                    {
                        Status = false,
                        Message = "Access token has not yet expired"
                    });
                }

                //check 4: Check refreshtoken exist in DB
                var storedToken = _context.RefreshTokens.FirstOrDefault(x => x.Token == model.RefreshToken);
                if (storedToken == null)
                {
                    return Ok(new ApiResponse
                    {
                        Status = false,
                        Message = "Refresh token does not exist"
                    });
                }

                //check 5: check refreshToken is used/revoked?
                if (storedToken.IsUsed)
                {
                    return Ok(new ApiResponse
                    {
                        Status = false,
                        Message = "Refresh token has been used"
                    });
                }
                if (storedToken.IsLocked)
                {
                    return Ok(new ApiResponse
                    {
                        Status = false,
                        Message = "Refresh token has been revoked"
                    });
                }

                //check 6: AccessToken id == JwtId in RefreshToken
                var jti = tokenInVerification.Claims.FirstOrDefault(x => x.Type == JwtRegisteredClaimNames.Jti).Value;
                if (storedToken.JwtId != jti)
                {
                    return Ok(new ApiResponse
                    {
                        Status = false,
                        Message = "Token doesn't match"
                    });
                }

                //Update token is used
                storedToken.IsLocked = true;
                storedToken.IsUsed = true;
                _context.Update(storedToken);
                await _context.SaveChangesAsync();

                //create new token
                var user = await _context.Users.SingleOrDefaultAsync(nd => nd.Id == storedToken.UserId);
                var token = await GenerateToken(user);

                return Ok(new ApiResponse
                {
                    Status = true,
                    Message = "Renew token success",
                    Data = token
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ApiResponse
                {
                    Status = false,
                    Message = "Something went wrong"
                });
            }
        }
        private DateTime ConvertUnixTimeToDateTime(long utcExpireDate)
        {
            var dateTimeInterval = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            dateTimeInterval.AddSeconds(utcExpireDate).ToUniversalTime();

            return dateTimeInterval;
        }
    }
}
