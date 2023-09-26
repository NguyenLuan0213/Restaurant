using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class MenusController : ControllerBase
    {
        private readonly IMenuRepository _menuRepository;
        private readonly IMapper _mapper;

        public MenusController(IMenuRepository menuRepository, IMapper mapper)
        {
            _menuRepository = menuRepository;
            _mapper = mapper;
        }

        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Menu>))]
        public IActionResult GetMenus()
        {
            var menu = _mapper.Map<List<MenuDTO>>(_menuRepository.GetMenus());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(menu);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Menu))]
        [ProducesResponseType(400)]
        public IActionResult GetMenus(int id)
        {
            if (!_menuRepository.MenuExists(id))
            {
                return NotFound();
            }
            var menu = _mapper.Map<MenuDTO>(_menuRepository.GetMenuId(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(menu);
        }

        [HttpGet("restaurant/{id}")]
        [ProducesResponseType(200, Type = typeof(Menu))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetMenusByRestaurant(int id)
        {
            if (!_menuRepository.MenuExists(id))
            {
                return NotFound();
            }
            var menu = _mapper.Map<List<MenuDTO>>(_menuRepository.GetMenuByRestaurantId(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(menu);
        }

        // Post api/menus
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(MenuDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateMenu([FromBody] MenuDTO menuDTO)
        {
            if (menuDTO == null)
            {
                return BadRequest(ModelState);
            }

            var menu = new Menu()
            {
                Name = menuDTO.Name,
                Description = menuDTO.Description,
                RestaurantId = menuDTO.RestaurantId

            };
            _mapper.Map<Menu>(menuDTO);

            if (!_menuRepository.CreateMenu(menu))
            {
                return BadRequest("Uanble to create menu");
            }

            var createdMenuDTO = _mapper.Map<MenuDTO>(menu);
            return CreatedAtAction(nameof(GetMenus), new { id = createdMenuDTO.Id }, createdMenuDTO);
        }

        // PUT api/menus/
        [HttpPut("upadate/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateMenu(int id, [FromBody] MenuDTO menuDTO)
        {
            if (menuDTO == null || id != menuDTO.Id)
            {
                return BadRequest("Invalid data");
            }

            if (!_menuRepository.MenuExists(id))
            {
                return NotFound();
            }
            var menu = new Menu()
            {
                Id = menuDTO.Id,
                Name = menuDTO.Name,
                Description = menuDTO.Description,
                RestaurantId = menuDTO.RestaurantId
            };
            _mapper.Map<Menu>(menuDTO);

            if (!_menuRepository.UpdateMenu(menu))
            {
                return BadRequest("Unable to update menu");
            }
            return NoContent();
        }

        // DELETE api/menus/{id}
        [HttpDelete("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteMenu(int id)
        {
            if (!_menuRepository.MenuExists(id))
            {
                return NotFound();
            }
          
            if (!_menuRepository.DeleteMenu(id))
            {
                return BadRequest("Unable to delete menu");
            }

            return NoContent();
        }

    }
}
