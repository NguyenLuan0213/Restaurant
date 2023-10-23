using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;
using Restaurant.Data;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class RestaurantsbrController :ControllerBase
    {
        private readonly Cloudinary _cloudinary;
        private readonly IRestaurantsbrRepository _resrepo;
        private readonly IMapper _mapper;

        public RestaurantsbrController(IRestaurantsbrRepository resrepo, RestaurantContext restcontext, IMapper mapper)
        {
            var cloudinaryCredentials = new CloudinaryDotNet.Account(
            "dkba7robk",
            "325815158184357",
            "TxTGacbxcxoBBarPbpPwB4XCuc0");
            _cloudinary = new Cloudinary(cloudinaryCredentials);
            _resrepo = resrepo;
            this._mapper = mapper;
        }

        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Restaurantsbr>))]
        public IActionResult GetRestaurantsbrs()
        {
            var restaurantsbrs = _mapper.Map<List<RestaurantsbrDTO>>(_resrepo.GetRestaurantsbrs());

            if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }
            return Ok(restaurantsbrs);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Restaurantsbr))]
        [ProducesResponseType(400)]
        public IActionResult GetRestaurantsbrs(int id)
        {
            if(!_resrepo.RestaurantsbrExists(id))
            {
                return NotFound();
            }

            var restaurantsbr = _mapper.Map<RestaurantsbrDTO>(_resrepo.GetRestaurantsbr(id));
            
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            return Ok(restaurantsbr);
        }

        // Post api/restaurantsbr
        [HttpPost]
        public IActionResult CreateRestaurant([FromForm] RestaurantsbrDTO restaurantDTO, IFormFile file)
        {
            if (restaurantDTO == null)
            {
                return BadRequest("Invalid data");
            }
            if (file == null || file.Length == 0)
            {
                return BadRequest("Không có tệp ảnh được gửi lên.");
            }
            // Tải ảnh lên Cloudinary
            var uploadParams = new ImageUploadParams
            {
                File = new FileDescription(file.FileName, file.OpenReadStream()),
                Transformation = new Transformation().Crop("fill").Width(400).Height(400),
                // Cấu hình các biến đổi hoặc options khác nếu cần
            };

            var uploadResult = _cloudinary.Upload(uploadParams);

            // Lấy URL công khai của ảnh trên Cloudinary
            var imageUrl = uploadResult.SecureUri.AbsoluteUri;
            // Ánh xạ DTO thành đối tượng Restaurantsbr
            var restaurant = new Restaurantsbr()
            {
                Name = restaurantDTO.Name,
                Address = restaurantDTO.Address,
                Description = restaurantDTO.Description,
                Image = imageUrl,
            };

            _mapper.Map<Restaurantsbr>(restaurantDTO);

            // Thực hiện thêm nhà hàng vào cơ sở dữ liệu
            if (!_resrepo.CreateRestaurantsbr(restaurant))
            {
                return BadRequest("Unable to create restaurant");
            }
            else
            {
                // Ánh xạ lại đối tượng thành DTO để trả về cho client
                var createdRestaurantDTO = _mapper.Map<RestaurantsbrDTO>(restaurant);

                // Trả về mã trạng thái 201 Created và đối tượng đã được tạo
                return CreatedAtAction(nameof(GetRestaurantsbrs), new { id = createdRestaurantDTO.Id }, createdRestaurantDTO);
            }    
           
        }


        // PUT api/restaurantsbr/id
        [HttpPut("update/{id}")]
        public IActionResult UpdateRestaurant(int id, [FromForm] RestaurantsbrDTO restaurantDTO, IFormFile? file)
        {
            if (restaurantDTO == null || id != restaurantDTO.Id)
            {
                return BadRequest("Dữ liệu không hợp lệ");
            }

            // Kiểm tra xem nhà hàng có tồn tại không
            var existingRestaurant = _resrepo.GetRestaurantsbr(id);
            if (existingRestaurant == null)
            {
                return NotFound();
            }

            // Nếu có tệp ảnh được gửi lên và tệp đó có kích thước lớn hơn 0, thì tải ảnh lên
            if (restaurantDTO.File != null && restaurantDTO.File.Length > 0)
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

                existingRestaurant.Image = imageUrl;
            }
            else
            {
                existingRestaurant.Image = restaurantDTO.Image;
            }    

            existingRestaurant.Name = restaurantDTO.Name;
            existingRestaurant.Address = restaurantDTO.Address;
            existingRestaurant.Description = restaurantDTO.Description;

            _mapper.Map(restaurantDTO, existingRestaurant);

            // Thực hiện cập nhật nhà hàng vào cơ sở dữ liệu
            if (!_resrepo.UpdateRestaurantsbr(existingRestaurant))
            {
                return BadRequest("Không thể cập nhật nhà hàng");
            }

            // Trả về mã trạng thái 204 No Content
            return NoContent();
        }


        // DELETE api/restaurantsbr/id
        [HttpDelete("{id}")]
        public IActionResult DeleteRestaurant(int id)
        {
            // Kiểm tra xem nhà hàng có tồn tại không
            if (!_resrepo.RestaurantsbrExists(id))
            {
                return NotFound();
            }
            // Thực hiện xóa nhà hàng khỏi cơ sở dữ liệu
            if (!_resrepo.DeleteRestaurantsbr(id))
            {
                return BadRequest("Unable to delete restaurant");
            }
            // Trả về mã trạng thái 204 No Content
            return NoContent();
        }
        
    }
}
