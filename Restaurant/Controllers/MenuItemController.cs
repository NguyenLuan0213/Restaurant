using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Models;
using Restaurant.Dto;
using Restaurant.Repository;

namespace Restaurant.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MenuItemController : ControllerBase
    {
        private readonly IMenuItemRepository _menuItemRepository;
        private readonly IMapper _mapper;

        public MenuItemController(IMenuItemRepository menuItemRepository, IMapper mapper)
        {
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
        [ProducesResponseType(200, Type = typeof(Menuitem))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetMenuItemByMenu(int id)
        {
            var menuItem = _menuItemRepository.GetMenuItemByMenu(id);
            if (menuItem == null || !menuItem.Any())
            {
                return NotFound();
            }
            var menuItemDTO = _mapper.Map<ICollection<MenuItemDTO>>(menuItem);

            return Ok(menuItem);
        }

        // POST: api/MenuItem
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(MenuItemDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateMenuItem([FromBody] MenuItemDTO menuItemDTO)
        {
            if (menuItemDTO == null)
            {
                return BadRequest("Invalid data");
            }
            
            var menuItem = new Menuitem()
            {
                Name = menuItemDTO.Name,
                Description = menuItemDTO.Description,
                Price = menuItemDTO.Price,
                MenuId = menuItemDTO.MenuId,
                //Img = menuItemDTO.Img,
            };
            _mapper.Map<MenuItemDTO>(menuItem);

            if(!_menuItemRepository.CreateMenuItem(menuItem))
            {
                return BadRequest("Unable to create menu item");
            };

            var createdMenuItemDTO = _mapper.Map<MenuItemDTO>(menuItem);

            return CreatedAtAction(nameof(GetMenuItemId), new {id = createdMenuItemDTO.Id}, createdMenuItemDTO);
        }

        // PUT: api/MenuItem/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateMenuItem(int id, [FromBody] MenuItemDTO menuItemDTO)
        {
            if (menuItemDTO == null || id != menuItemDTO.Id)
            {
                return BadRequest("Invalid data");
            }

            if (!_menuItemRepository.MenuItemExists(id))
            {
                return NotFound();
            }

            var menuItem = new Menuitem()
            {
                Id = menuItemDTO.Id,
                Name = menuItemDTO.Name,
                Description = menuItemDTO.Description,
                Price = menuItemDTO.Price,
                MenuId = menuItemDTO.MenuId,
            };
            _mapper.Map<Menuitem>(menuItemDTO);

            if (!_menuItemRepository.UpdateMenuItem(menuItem))
            {
                return BadRequest("Unable to update menu item");
            }
            return NoContent();
        }

        // DELETE: api/MenuItem/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
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
