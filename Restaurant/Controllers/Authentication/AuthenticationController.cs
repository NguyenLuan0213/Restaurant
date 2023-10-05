using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Models.SignUp;
using Restaurant.Models;
using Restaurant.Models.Login;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using NuGet.Protocol.Core.Types;
using Restaurant.Models.Users;
using Restaurant.Models.Identity;

namespace Restaurant.Controllers.Authentication
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly UserManager<User> _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly RoleManager<Role> _roleManager;
        private readonly IConfiguration _configuration;

        public AuthenticationController(UserManager<User> userManager,
            RoleManager<Role> roleManager, SignInManager<User> signInManager,
            IConfiguration configuration)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _signInManager = signInManager;
            _configuration = configuration;
        }

        [HttpPost("registry")]
        public async Task<IActionResult> Register([FromBody] RegisterUser registerUser)
        {

            //Check User
            var userExist = await _userManager.FindByEmailAsync(registerUser.Email);
            if (userExist != null)
            {
                return StatusCode(StatusCodes.Status403Forbidden,
                    new Response { Status = "Error", Message = "User already exists!" });
            }

            //Create User in database
            var user = new User()
            {
                Email = registerUser.Email,
                UserName = registerUser.Username,
                PhoneNumber = registerUser.PhoneNumber,
                Address = registerUser.Address,
                Fullname = registerUser.Fullname,
                BrithDay = registerUser.BirthDay,
                Gender = registerUser.Gender,
                SecurityStamp = Guid.NewGuid().ToString()
            };
            if (await _roleManager.RoleExistsAsync(registerUser.Roles))
            {
                var result = await _userManager.CreateAsync(user, registerUser.Password);

                if (!result.Succeeded)
                {
                    var errors = result.Errors;
                    return StatusCode(StatusCodes.Status500InternalServerError,
                        new Response { Status = "Error", Message = "User Failed to Create" });
                }

                await _userManager.AddToRoleAsync(user, registerUser.Roles);
                {
                    return Ok(new Response
                    {
                        Status = "Success",
                        Message = "User Created Successfully"
                    });
                }
            }
            else
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                    new Response { Status = "Error", Message = "User Creation Failed" });
            }
        }

        //    [HttpGet("email")]
        //    public async Task<IActionResult> ConfirmEmail(string token, string email)
        //    {
        //        var user = await _userManager.FindByEmailAsync(email);
        //        if (user != null)
        //        {
        //            var result = await _userManager.ConfirmEmailAsync(user, token);
        //            if (result.Succeeded)
        //            {
        //                return StatusCode(StatusCodes.Status200OK,
        //                  new Response { Status = "Success", Message = "Email Verified Successfully" });
        //            }
        //        }
        //        return StatusCode(StatusCodes.Status500InternalServerError,
        //                   new Response { Status = "Error", Message = "This User Doesnot exist!" });
        //    }



        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {
            var user = await _userManager.FindByNameAsync(loginModel.Username);

            if (user != null)
            {
                var loginResult = await _signInManager.PasswordSignInAsync(user, loginModel.Password, false, true);

                if (loginResult.Succeeded)
                {
                    if (user.TwoFactorEnabled)
                    {
                        var token = await _userManager.GenerateTwoFactorTokenAsync(user, "Email");

                        //var message = new Message(new string[] { user.Email! }, "OTP Confirmation", token);
                        //_emailService.SendEmail(message);

                        return StatusCode(StatusCodes.Status200OK,
                         new Response { Status = "Success", Message = $"We have sent an OTP to your Email {user.Email}" });
                    }

                    var authClaims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.MobilePhone, user.PhoneNumber),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            };
                    var userRoles = await _userManager.GetRolesAsync(user);
                    foreach (var role in userRoles)
                    {
                        authClaims.Add(new Claim(ClaimTypes.Role, role));
                    }

                    var jwtToken = GetToken(authClaims);

                    return Ok(new
                    {
                        token = new JwtSecurityTokenHandler().WriteToken(jwtToken),
                        expiration = jwtToken.ValidTo,
                    });
                }
            }

            // Trả về BadRequest nếu đăng nhập thất bại
            return BadRequest(new Response { Status = "Error", Message = "Invalid username or password" });
        }



        private JwtSecurityToken GetToken(List<Claim> authClaims)
        {
            var authSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));

            var token = new JwtSecurityToken(
                issuer: _configuration["JWT:ValidIssuer"],
                audience: _configuration["JWT:ValidAudience"],
                expires: DateTime.Now.AddDays(2),
                claims: authClaims,
                signingCredentials: new SigningCredentials(authSigningKey, SecurityAlgorithms.HmacSha256)
                );

            return token;
        }

        [HttpPost("roles")]
        public async Task<IActionResult> CreateRole([FromBody] string role)
        {
            if (await _roleManager.RoleExistsAsync(role))
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                                       new Response { Status = "Error", Message = "Role already exists!" });
            }
            var roles = new Role()
            {
                Name = role,
                NormalizedName = role.ToUpper(),
                ConcurrencyStamp = Guid.NewGuid().ToString()
            };
            var result = await _roleManager.CreateAsync(roles);
            if (!result.Succeeded)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                                       new Response { Status = "Error", Message = "Role Creation Failed" });
            }
            return Ok(new Response { Status = "Success", Message = "Role Created Successfully" });
        }


        [HttpPost("logout")]
        public IActionResult Logout()
        {
            Response.Cookies.Delete("jwt");

            return Ok(new
            {
                message = "success"
            });
        }

        [HttpGet("user")]
        public async Task<IActionResult> GetUser(string username)
        {
            var user = await _userManager.FindByNameAsync(username);
            if (user != null)
            {
                var userRoles = await _userManager.GetRolesAsync(user); // Lấy danh sách các roles của người dùng

                var userInformation = new
                {
                    Id = user.Id,
                    FullName = user?.Fullname, // Giả sử bạn có thuộc tính FullName trong ApplicationUser
                    Email = user?.Email,
                    PhoneNumber = user?.PhoneNumber,
                    Address = user?.Address,
                    Gender = user?.Gender,
                    BirthDay = user?.BrithDay,
                    Roles = userRoles // Danh sách các roles của người dùng
                };

                return Ok(userInformation);
            }
            return NotFound(); // Hoặc Unauthorized nếu bạn muốn ẩn thông tin về sự không tồn tại của người dùng
        }

    }
}
