using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Restaurant.DTO;
using Restaurant.Models;
using Restaurant.Models.Login;
using Restaurant.Models.SignUp;
using Restaurant.Models.Users;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Restaurant.Controllers.Authentication
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly Cloudinary _cloudinary;
        private readonly UserManager<User> _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly RoleManager<Models.Identity.Role> _roleManager;
        private readonly IConfiguration _configuration;

        public AuthenticationController(UserManager<User> userManager,
            RoleManager<Models.Identity.Role> roleManager, SignInManager<User> signInManager,
            IConfiguration configuration)
        {
            var cloudinaryCredentials = new CloudinaryDotNet.Account(
            "dkba7robk",
            "325815158184357",
            "TxTGacbxcxoBBarPbpPwB4XCuc0");
            _cloudinary = new Cloudinary(cloudinaryCredentials);
            _userManager = userManager;
            _roleManager = roleManager;
            _signInManager = signInManager;
            _configuration = configuration;
        }

        [HttpPost("registry")]
        public async Task<IActionResult> Register([FromForm] RegisterUser registerUser, IFormFile file)
        {
            // Check if the user with the same email already exists
            var userExist = await _userManager.FindByEmailAsync(registerUser.Email);
            if (userExist != null)
            {
                return StatusCode(StatusCodes.Status403Forbidden,
                    new Response { Status = "Error", Message = "User with this email already exists!" });
            }

            // Check if a valid image file is provided
            if (file == null || file.Length == 0)
            {
                return BadRequest("Không có tệp ảnh được gửi lên.");
            }

            var image = "";
            if (file != null && file.Length > 0)
            {
                // Upload the image to Cloudinary or perform other image processing as needed
                var uploadParams = new ImageUploadParams
                {
                    File = new FileDescription(file.FileName, file.OpenReadStream()),
                    Transformation = new Transformation().Crop("fill").Width(400).Height(400),
                    // Configure other transformations or options as needed
                };

                var uploadResult = _cloudinary.Upload(uploadParams);

                // Get the public URL of the uploaded image from Cloudinary
                var imageUrl = uploadResult.SecureUri?.AbsoluteUri;

                if (!string.IsNullOrEmpty(imageUrl))
                {
                    image = imageUrl;
                }
                else
                {
                    // Handle the case where the image upload failed
                    return StatusCode(StatusCodes.Status500InternalServerError,
                        new Response { Status = "Error", Message = "Failed to upload image." });
                }
            }

            // Create the user in the database
            var user = new User()
            {
                Email = registerUser.Email,
                UserName = registerUser.Username,
                PhoneNumber = registerUser.PhoneNumber,
                Address = registerUser.Address,
                Fullname = registerUser.Fullname,
                BrithDay = DateOnly.Parse(registerUser.BirthDay),
                Gender = registerUser.Gender,
                Image = image,
                SecurityStamp = Guid.NewGuid().ToString()
            };

            // Check if the specified role exists
            if (await _roleManager.RoleExistsAsync(registerUser.Roles))
            {
                var result = await _userManager.CreateAsync(user, registerUser.Password);

                if (result.Succeeded)
                {
                    // Add the user to the specified role
                    await _userManager.AddToRoleAsync(user, registerUser.Roles);

                    return Ok(new Response
                    {
                        Status = "Success",
                        Message = "User Created Successfully"
                    });
                }
                else
                {
                    // Handle the case where user creation failed
                    var errors = result.Errors;
                    return StatusCode(StatusCodes.Status500InternalServerError,
                        new Response { Status = "Error", Message = "User Failed to Create" });
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
        public async Task<IActionResult> CreateRole([FromBody] RolesDTO roleDTO)
        {
            if (await _roleManager.RoleExistsAsync(roleDTO.Name))
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                                       new Response { Status = "Error", Message = "Role already exists!" });
            }
            var roles = new Models.Identity.Role()
            {
                Name = roleDTO.Name,
                NormalizedName = roleDTO.Name.ToUpper(),
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
                    Image = user?.Image,
                    Roles = userRoles // Danh sách các roles của người dùng
                };

                return Ok(userInformation);
            }
            return NotFound(); // Hoặc Unauthorized nếu bạn muốn ẩn thông tin về sự không tồn tại của người dùng
        }

        [HttpGet("getAllUsers")]
        public async Task<IActionResult> GetAllUsers()
        {
            // Lấy danh sách tất cả người dùng
            var users = await _userManager.Users.ToListAsync();

            if (users != null && users.Any())
            {
                // Tạo danh sách chứa thông tin về các người dùng
                var usersInformation = users.Select(user => new
                {
                    Id = user.Id,
                    Username = user.UserName,
                    FullName = user.Fullname,
                    Email = user.Email,
                    PhoneNumber = user.PhoneNumber,
                    Address = user.Address,
                    Gender = user.Gender,
                    BirthDay = user.BrithDay,
                    Image = user.Image,
                    Roles = _userManager.GetRolesAsync(user).Result,
                });

                return Ok(usersInformation);
            }

            return NotFound(); // Hoặc Unauthorized nếu bạn muốn ẩn thông tin về sự không tồn tại của người dùng
        }

        [HttpGet]
        [Route("getRoles")]
        public IActionResult GetRoles()
        {
            var roles = _roleManager.Roles.ToList();

            var rolesInformation = roles.Select(role => new
            {
                Id = role.Id,
                Name = role.Name,
                NormalizedName = role.NormalizedName,
                ConcurrencyStamp = role.ConcurrencyStamp
            });

            return Ok(roles);
        }

        [HttpGet]
        [Route("getSumUser")]
        public IActionResult GetSumUser()
        {
            var users = _userManager.Users.ToList();
            var sumUser = users.Count();
            return Ok(sumUser);
        }

        [HttpPut("update/{userId}")]
        public async Task<IActionResult> UpdateUser(string userId, [FromForm] UpdateUserDTO updateUserDTO, IFormFile? file)
        {
            // Tìm người dùng theo userId
            var user = await _userManager.FindByIdAsync(userId);

            if (user == null)
            {
                return NotFound("Không tìm thấy người dùng.");
            }

            // Cập nhật thông tin người dùng từ updateUserModel

            user.Email = updateUserDTO.Email;
            user.PhoneNumber = updateUserDTO.PhoneNumber;
            user.Address = updateUserDTO.Address;
            user.Gender = updateUserDTO.Gender;
            user.Fullname = updateUserDTO.Fullname;

            if (!string.IsNullOrEmpty(updateUserDTO.Birthday) && DateTime.TryParse(updateUserDTO.Birthday, out DateTime birthday))
            {
                user.BrithDay = DateOnly.FromDateTime(birthday);
            }

            // Nếu có tệp ảnh được gửi lên và tệp đó có kích thước lớn hơn 0, thì tải ảnh lên
            if (updateUserDTO.File != null && updateUserDTO.File.Length > 0)
            {
                // Tải ảnh lên Cloudinary hoặc thực hiện xử lý ảnh khác tùy ý ở đây
                var uploadParams = new ImageUploadParams
                {
                    File = new FileDescription(file.FileName, file.OpenReadStream()),
                    Transformation = new Transformation().Crop("fill").Width(400).Height(400),
                    // Cấu hình các biến đổi hoặc options khác nếu cần
                };

                var uploadResult = _cloudinary.Upload(uploadParams);

                // Lấy URL công khai của ảnh trên Cloudinary
                var imageUrl = uploadResult.SecureUri.AbsoluteUri;

                user.Image = imageUrl;
            }
            else
            {
                user.Image = updateUserDTO.Image;
            }

            // Lưu các thay đổi vào cơ sở dữ liệu
            var result = await _userManager.UpdateAsync(user);

            if (result.Succeeded)
            {
                return Ok("Cập nhật người dùng thành công.");
                //// Lấy danh sách vai trò hiện tại của người dùng
                //var userRoles = await _userManager.GetRolesAsync(user);

                //// Lấy danh sách các vai trò mới từ DTO
                //var roles = updateUserDTO.Roles.Select(role => role.ToString()).ToList();

                //// Kiểm tra xem có sự thay đổi trong vai trò hay không
                //var rolesAdded = new List<string>();
                //var rolesRemoved = new List<string>();

                //// Tìm các vai trò mới (rolesAdded)
                //foreach (var role in roles)
                //{
                //    if (!userRoles.Contains(role) && _roleManager.RoleExistsAsync(role).Result)
                //    {
                //        rolesAdded.Add(role);
                //    }
                //}

                //// Tìm các vai trò bị loại bỏ (rolesRemoved)
                //foreach (var userRole in userRoles)
                //{
                //    if (!roles.Contains(userRole) && _roleManager.RoleExistsAsync(userRole).Result)
                //    {
                //        rolesRemoved.Add(userRole);
                //    }
                //}

                //if (rolesAdded.Any() || rolesRemoved.Any())
                //{
                //    await _userManager.RemoveFromRolesAsync(user, rolesRemoved);
                //    await _userManager.AddToRolesAsync(user, rolesAdded);

                //    // Lưu các thay đổi vào cơ sở dữ liệu
                //    var updateResult = await _userManager.UpdateAsync(user);

                //    if (updateResult.Succeeded)
                //    {
                //        return Ok("Cập nhật người dùng thành công.");
                //    }
                //    else
                //    {
                //        var updateErrors = updateResult.Errors.Select(e => e.Description);
                //        return BadRequest($"Lỗi khi cập nhật người dùng: {string.Join(", ", updateErrors)}");
                //    }
            }
            else
            {
                // Nếu không có sự thay đổi hoặc có vai trò mới không tồn tại, trả về lỗi
                return BadRequest("Có lỗi xảy ra");
            }
        }

        [HttpDelete("delete/{userId}")]
        public async Task<IActionResult> DeleteUser(string userId)
        {
            // Tìm người dùng theo userId
            var user = await _userManager.FindByIdAsync(userId);
            if (user == null)
            {
                return NotFound("Không tìm thấy người dùng.");
            }
            // Xóa người dùng
            var result = await _userManager.DeleteAsync(user);
            if (result.Succeeded)
            {
                return Ok("Xóa người dùng thành công.");
            }
            else
            {
                var deleteErrors = result.Errors.Select(e => e.Description);
                return BadRequest($"Lỗi khi xóa người dùng: {string.Join(", ", deleteErrors)}");
            }
        }

        [HttpPut("updateRole/{roleId}")]
        public async Task<IActionResult> UpdateRole(string roleId, [FromBody] RolesDTO rolesDTO)
        {
            var role = await _roleManager.FindByIdAsync(roleId);
            if (role == null)
            {
                return NotFound("Không tìm thấy vai trò.");
            }
            role.Name = rolesDTO.Name;
            role.NormalizedName = role.NormalizedName;
            role.ConcurrencyStamp = role.ConcurrencyStamp;
            var result = await _roleManager.UpdateAsync(role);
            if (result.Succeeded)
            {
                return Ok("Cập nhật vai trò thành công.");
            }
            else
            {
                var updateErrors = result.Errors.Select(e => e.Description);
                return BadRequest($"Lỗi khi cập nhật vai trò: {string.Join(", ", updateErrors)}");
            }
        }

        [HttpDelete("deleteRole/{roleId}")]
        public async Task<IActionResult> DeleteRole(string roleId)
        {
            var role = await _roleManager.FindByIdAsync(roleId);
            if (role == null)
            {
                return NotFound("Không tìm thấy vai trò.");
            }
            var result = await _roleManager.DeleteAsync(role);
            if (result.Succeeded)
            {
                return Ok("Xóa vai trò thành công.");
            }
            else
            {
                var deleteErrors = result.Errors.Select(e => e.Description);
                return BadRequest($"Lỗi khi xóa vai trò: {string.Join(", ", deleteErrors)}");
            }
        }
    }
}