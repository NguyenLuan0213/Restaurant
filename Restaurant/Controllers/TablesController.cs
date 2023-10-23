using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using Restaurant.DTO;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    //[Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class TablesController : ControllerBase
    {
        private readonly ITablesRepository _tablesRepository;
        private readonly IMapper _mapper;

        public TablesController(ITablesRepository tablesRepository, IMapper mapper)
        {
            _tablesRepository = tablesRepository;
            _mapper = mapper;
        }

        // GET: api/Tables
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Table>))]
        public IActionResult GetTables()
        {
            var table = _mapper.Map<List<TablesDTO>>(_tablesRepository.GetTables());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(table);
        }

        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Table))]
        [ProducesResponseType(400)]
        public IActionResult GetTables(int id)
        {
            if (!_tablesRepository.TableExists(id))
            {
                return NotFound();
            }

            var tabes = _mapper.Map<TablesDTO>(_tablesRepository.GetTable(id));

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            return Ok(tabes);
        }

        [HttpGet("restaurant/{id}")]
        [ProducesResponseType(200, Type = typeof(Table))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetTablesByRestaurantId(int id)
        {
            if (!_tablesRepository.TableExists(id))
            {
                return NotFound();
            }

            var tables = _tablesRepository.GetTablesByRestaurantId(id);

            if (tables == null || !tables.Any())
            {
                return NotFound();
            }

            var tableDTOs = tables.Select(table => new TablesDTO
            {
                Id = table.Id,
                RestaurantId = table.RestaurantId,
                TableNumber = table.TableNumber,
                Seats = table.Seats,
                Status = table.Status,
                IdWaiter = table.IdWaiter
                // Map các trường khác tại đây nếu cần
            }).ToList();

            return Ok(tableDTOs);
        }

        [HttpGet("status/{status}")]
        [ProducesResponseType(200, Type = typeof(ICollection<TablesDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetTablesByRestaurantIdAndStatus(int restaurantId, string status)
        {
            if (!_tablesRepository.TableExists(restaurantId))
            {
                return NotFound();
            }

            var tables = _tablesRepository.GetTablesByRestaurantIdAndStatus(restaurantId, status);

            if (tables == null || !tables.Any())
            {
                return BadRequest();
            }

            var tableDTOs = _mapper.Map<ICollection<TablesDTO>>(tables);

            return Ok(tableDTOs);
        }

        // POST: api/Tables
        [HttpPost]
        public IActionResult PostTables([FromBody] TablesDTO tablesDTO)
        {
            if (tablesDTO == null)
            {
                return BadRequest("Invalid data");
            }
            // Ánh xạ DTO thành đối tượng Restaurantsbr
            var table = new Table()
            {
                RestaurantId = tablesDTO.RestaurantId,
                TableNumber = tablesDTO.TableNumber,
                Seats = tablesDTO.Seats,
                Status = tablesDTO.Status,
                IdWaiter = tablesDTO.IdWaiter
            };

            _mapper.Map<Table>(tablesDTO);

            //Thực hiện thêm vào database
            if (!_tablesRepository.CreateTable(table))
            {
                return BadRequest("Unable to create restaurant");
            }
            else
            {
                var createdTablesDTO = _mapper.Map<TablesDTO>(table);

                return CreatedAtAction(nameof(GetTables), new { id = createdTablesDTO.Id }, createdTablesDTO);
            }
            
        }

        // PUT: api/Tables/update
        [HttpPut("update/{id}")]
        public IActionResult PutTable(int id, [FromBody] TablesDTO tableDTO)
        {
            if (tableDTO == null || id != tableDTO.Id)
            {
                return BadRequest("Invalid data");
            }

            try
            {
                // Kiểm tra xem bàn có tồn tại không
                if (!_tablesRepository.TableExists(id))
                {
                    return NotFound(); // Không tìm thấy bàn để cập nhật
                }

                // Ánh xạ DTO thành đối tượng
                var table = new Table()
                {
                    Id = tableDTO.Id,
                    RestaurantId = tableDTO.RestaurantId,
                    TableNumber = tableDTO.TableNumber,
                    Seats = tableDTO.Seats,
                    Status = tableDTO.Status,
                    IdWaiter = tableDTO.IdWaiter
                };

                // Cập nhật
                if (!_tablesRepository.UpdateTable(table))
                {
                    return BadRequest("Unable to update table");
                }

                return NoContent(); // Cập nhật thành công
            }
            catch (Exception ex)
            {
                return BadRequest("Unable to update table: " + ex.Message); // Xử lý và trả về thông báo lỗi
            }
        }

        // DELETE api/tables/{id}
        [HttpDelete("{id}")]
        public IActionResult DeleteTable(int id)
        {
            if (!_tablesRepository.TableExists(id))
            {
                return NotFound(); // Không tìm thấy bàn để xóa
            }

            // Thực hiện xóa bàn
            if (!_tablesRepository.DeleteTable(id))
            {
                return BadRequest("Unable to delete table");
            }

            return Ok("Table deleted successfully"); // Xóa thành công
        }
    }
}
