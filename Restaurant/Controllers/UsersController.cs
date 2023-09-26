using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Restaurant.Models;
using Restaurant.DTO;
using Restaurant.Repository;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN")]
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly IUsersRepository _usersRepository;
        private readonly IMapper _mapper;

        public UsersController(IUsersRepository usersRepository, IMapper mapper)
        {
            _usersRepository = usersRepository;
            _mapper = mapper;
        }

        // GET: api/Users
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<UsersDTO>))]
        public IActionResult GetUsers()
        {
            var users = _mapper.Map<List<UsersDTO>>(_usersRepository.GetUsers());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(users);
        }

        // GET: api/Users/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(UsersDTO))]
        [ProducesResponseType(400)]
        public IActionResult GetUsers(int id)
        {
            if (!_usersRepository.UserExists(id))
            {
                return NotFound();
            }
            var users = _mapper.Map<UsersDTO>(_usersRepository.GetUserById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(users);
        }

        // GET: api/Users/role
        [HttpGet("role/{role}")]
        [ProducesResponseType(200, Type = typeof(UsersDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetUsersByRole(string role)
        {
            var users = _usersRepository.GetUsersByRole(role);
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (users == null || !users.Any())
            {
                return NotFound();
            }
            var usersDTO = _mapper.Map<List<UsersDTO>>(users);
            return Ok(usersDTO);
        }

        // GET: api/Users/fullname
        [HttpGet("fullname/{fullname}")]
        [ProducesResponseType(200, Type = typeof(UsersDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetUsersByFullName(string fullname)
        {
            var users = _mapper.Map<UsersDTO>(_usersRepository.GetUserByFullname(fullname));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(users);
        }

        // GET: api/Users/email
        [HttpGet("email/{email}")]
        [ProducesResponseType(200, Type = typeof(UsersDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetUsersByEmail(string email)
        {
            var users = _mapper.Map<UsersDTO>(_usersRepository.GetUserByEmail(email));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(users);
        }

        // GET: api/Users/phonenumber
        [HttpGet("phonenumber/{phonenumber}")]
        [ProducesResponseType(200, Type = typeof(UsersDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetUsersByPhoneNumber(string phonenumber)
        {
            var users = _mapper.Map<UsersDTO>(_usersRepository.GetUserByPhoneNumber(phonenumber));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(users);
        }

        //// POST: api/Users
        //[HttpPost("add")]
        //[ProducesResponseType(201, Type = typeof(UsersDTO))]
        //[ProducesResponseType(400)]
        //public async Task<IActionResult> PostUsersAsync([FromBody] UsersDTO usersDTO, IFormFile image)
        //{
        //    if (usersDTO == null)
        //    {
        //        return BadRequest("Invalid data");
        //    }


        //    // Sử dụng dịch vụ IPhotoService để tải ảnh lên Cloudinary hoặc nơi khác
        //    var imageUrl = await _photoService.AddPhotoAsync(image);

        //    // Ánh xạ DTO thành đối tượng 
        //    var User = new User()
        //    {
        //        Fullname = usersDTO.Fullname,
        //        Email = usersDTO.Email,
        //        Phone = usersDTO.Phone,
        //        Username = usersDTO.Username,
        //        Password = usersDTO.Password,
        //        Roles = usersDTO.Roles,
        //        Address = usersDTO.Address,
        //        Image = imageUrl.Url.ToString(),
        //    };


        //    // Thêm vào database
        //    if (!_usersRepository.CreateUser(User))
        //    {
        //        return BadRequest("Unable to create User");
        //    }

        //    // Ánh xạ lại DTO
        //    var usersDTOs = _mapper.Map<UsersDTO>(User);

        //    // Trả về mã trạng thái 201 Created và đối tượng đã được tạo
        //    return CreatedAtAction(nameof(GetUsers), new { id = usersDTOs.Id }, usersDTOs);
        //}

        //// PUT: api/Users/{id}
        //[HttpPut("update/{id}")]
        //[ProducesResponseType(204)]
        //[ProducesResponseType(400)]
        //[ProducesResponseType(404)]
        //public async Task<IActionResult> PutUsers(int id, [FromBody] UsersDTO usersDTO, [FromForm] IFormFile image)
        //{
        //    if (usersDTO == null || id != usersDTO.Id)
        //    {
        //        return BadRequest("Invalid data");
        //    }

        //    try
        //    {
        //        // Kiểm tra xem người dùng có tồn tại không
        //        if (!_usersRepository.UserExists(id))
        //        {
        //            return NotFound(); // Không tìm thấy người dùng để cập nhật
        //        }
        //        ImageUploadResult uploadResult = null;

        //        if (image != null && image.Length > 0)
        //        {
        //            // Sử dụng dịch vụ IPhotoService để tải ảnh lên Cloudinary hoặc nơi khác
        //            uploadResult = await _photoService.AddPhotoAsync(image);
        //            string imageUrl = uploadResult.Uri.ToString();
        //            // Ánh xạ URL ảnh vào đối tượng người dùng
        //            usersDTO.Image = imageUrl;
        //        }

        //        // Ánh xạ DTO thành đối tượng 
        //        var User = new User()
        //        {
        //            Id = usersDTO.Id,
        //            Fullname = usersDTO.Fullname,
        //            Email = usersDTO.Email,
        //            Phone = usersDTO.Phone,
        //            Username = usersDTO.Username,
        //            Password = usersDTO.Password,
        //            Roles = usersDTO.Roles,
        //            Address = usersDTO.Address
        //        };
        //        // Cập nhật
        //        _usersRepository.UpdateUser(User);

        //        return NoContent(); // Cập nhật thành công
        //    }
        //    catch (Exception ex)
        //    {
        //        return BadRequest("Unable to update user: " + ex.Message); // Xử lý và trả về thông báo lỗi
        //    }
        //}

        // DELETE api/users/{id}
        [HttpDelete("{id}")]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteUser(int id)
        {
            if (!_usersRepository.UserExists(id))
            {
                return NotFound(); // Không tìm thấy người dùng để xóa
            }

            // Thực hiện xóa người dùng
            if (!_usersRepository.DeleteUser(id))
            {
                return BadRequest("Unable to delete user");
            }

            return Ok("User deleted successfully"); // Xóa thành công
        }
    }
}
