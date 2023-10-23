using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;
using System.Drawing;
using System.Drawing.Imaging;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Stripe;
using Restaurant.DTO;
using Restaurant.Repository.Interfaces;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class MenuItemController : ControllerBase
    {
        private readonly Cloudinary _cloudinary;
        private readonly IMenuItemRepository _menuItemRepository;
        private readonly IMapper _mapper;

        public MenuItemController(IMenuItemRepository menuItemRepository, IMapper mapper)
        {
            var cloudinaryCredentials = new CloudinaryDotNet.Account(
            "dkba7robk",
            "325815158184357",
            "TxTGacbxcxoBBarPbpPwB4XCuc0");
            _cloudinary = new Cloudinary(cloudinaryCredentials);
            _menuItemRepository = menuItemRepository;
            _mapper = mapper;
        }

        // GET: api/MenuItem
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Menuitem>))]
        public IActionResult GetMenuItems()
        {
            var menuItem = _mapper.Map<List<MenuItemDTO>>(_menuItemRepository.GetMenuItems());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(menuItem);
        }

        // GET: api/MenuItem/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Menuitem))]
        [ProducesResponseType(400)]
        public IActionResult GetMenuItemId(int id)
        {
            if (!_menuItemRepository.MenuItemExists(id))
            {
                return NotFound();
            }
            var menuItem = _mapper.Map<MenuItemDTO>(_menuItemRepository.GetMenuItemById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(menuItem);
        }

        // GET: api/MenuItem/name
        [HttpGet("name/{name}")]
        [ProducesResponseType(200, Type = typeof(Menuitem))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetMenuItemName(string name)
        {
            var menuItems = _menuItemRepository.GetMenuItemByNameItem(name);

            if (menuItems == null || menuItems.Count == 0)
            {
                return NotFound();
            }

            var menuItemsDTOs = _mapper.Map<List<MenuItemDTO>>(menuItems);

            return Ok(menuItemsDTOs);
        }


        // GET: api/MenuItem/menu
        [HttpGet("menu/{id}")]
        public IActionResult GetMenuItemByMenu(int id)
        {
            var menuItem = _menuItemRepository.GetMenuItemByMenu(id);
            if (menuItem == null || !menuItem.Any())
            {
                return NotFound();
            }
            var menuItemDTO = _mapper.Map<ICollection<MenuItemDTO>>(menuItem);

            return Ok(menuItemDTO);
        }

        // POST: api/MenuItem
        [HttpPost("add")]
        public IActionResult addMenuItem([FromForm] MenuItemDTO menuItemDTO,IFormFile file)
        {
            if (menuItemDTO == null)
            {
                return BadRequest(ModelState);
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

            var menuItem = new Menuitem()
            {
                Name = menuItemDTO.Name,
                Description = menuItemDTO.Description,
                MenuId = menuItemDTO.MenuId,
                Price = menuItemDTO.Price,
                Image = imageUrl,
            };
            _mapper.Map<Menuitem>(menuItemDTO);
            if (!_menuItemRepository.CreateMenuItem(menuItem))
            {
                return BadRequest("Uanble to create menu");
            }
            else
            {
                var createdMenuItemDTO = _mapper.Map<MenuItemDTO>(menuItem);
                return CreatedAtAction(nameof(GetMenuItemId), new { id = createdMenuItemDTO.Id }, createdMenuItemDTO);
            }
        }

        // PUT: api/MenuItem/id
        [HttpPut("update/{id}")]

        public IActionResult UpdateMenuItem(int id, [FromForm] MenuItemDTO menuItemDTO, IFormFile? file)
        {
            if (menuItemDTO == null || id != menuItemDTO.Id)
            {
                return BadRequest("Invalid data");
            }

            if (!_menuItemRepository.MenuItemExists(id))
            {
                return NotFound();
            }
            
            var menuItem = _menuItemRepository.GetMenuItemById(id);

            // Nếu có tệp ảnh được gửi lên và tệp đó có kích thước lớn hơn 0, thì tải ảnh lên
            if (menuItemDTO.File != null && menuItemDTO.File.Length > 0)
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

                menuItem.Image = imageUrl;
            }
            else
            {
                menuItem.Image = menuItemDTO.Image;
            }

            menuItem.Id = menuItemDTO.Id;
            menuItem.Name = menuItemDTO.Name;
            menuItem.Description = menuItemDTO.Description;
            menuItem.Price = menuItemDTO.Price;

            _mapper.Map<Menuitem>(menuItemDTO);

            if (!_menuItemRepository.UpdateMenuItem(menuItem))
            {
                return BadRequest("Unable to update menu item");
            }
            return NoContent();
        }

        // DELETE: api/MenuItem/id
        [HttpDelete("delete/{id}")]
        public IActionResult DeleteMenuItem(int id)
        {
            if (!_menuItemRepository.MenuItemExists(id))
            {
                return NotFound();
            }
            if (!_menuItemRepository.DeleteMenuItem(id))
            {
                return BadRequest("Unable to delete menu item");
            }
            return NoContent();
        }
    }
}
