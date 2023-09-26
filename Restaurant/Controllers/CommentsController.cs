using AutoMapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Restaurant.Dto;
using System.Xml.Linq;
using Restaurant.Repository;
using Restaurant.Models.RestaurantModels;
using Microsoft.AspNetCore.Authorization;

namespace Restaurant.Controllers
{
    [Authorize(Roles = "ADMIN,CASHIER")]
    [Route("api/[controller]")]
    [ApiController]
    public class CommentsController : ControllerBase
    {
        private readonly ICommentRepository _commentRepository;
        private readonly IMapper _mapper;

        public CommentsController(ICommentRepository commentRepository, IMapper mapper)
        {
            _commentRepository = commentRepository;
            _mapper = mapper;
        }


        // GET: api/Comments
        [HttpGet]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Comment>))]
        public IActionResult GetComments()
        {
            var comments = _mapper.Map<List<CommentDTO>>(_commentRepository.GetComments());
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(comments);
        }

        //Get: api/Comments/id
        [HttpGet("{id}")]
        [ProducesResponseType(200, Type = typeof(Comment))]
        [ProducesResponseType(400)]
        public IActionResult GetCommentId(int id)
        {
            if (!_commentRepository.CommentExists(id))
            {
                return NotFound();
            }
            var comment = _mapper.Map<CommentDTO>(_commentRepository.GetCommentById(id));
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            return Ok(comment);
        }

        //Get: api/Comments/rating
        [HttpGet("rating/{rating}")]
        [ProducesResponseType(200, Type = typeof(Comment))]
        [ProducesResponseType(400)]
        public IActionResult GetCommentByRating(int rating)
        {
            var comment = _commentRepository.GetCommentsByRating(rating);
            if (comment == null || !comment.Any())
            {
                return NotFound();
            }
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var commentDto = _mapper.Map<ICollection<CommentDTO>>(comment);
            return Ok(comment);
        }

        //Get: api/Comments/restaurant
        [HttpGet("restaurant/{restaurantId}")]
        [ProducesResponseType(200, Type = typeof(List<CommentDTO>))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult GetCommentsByRestaurantId(int restaurantId)
        {
            var comments = _commentRepository.GetCommentsByRestaurantId(restaurantId);
            if (comments == null || !comments.Any())
            {
                return NotFound();
            }
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var commentsDto = _mapper.Map<ICollection<CommentDTO>>(comments);

            return Ok(commentsDto);
        }

        //post: api/Comments
        [HttpPost]
        [ProducesResponseType(201, Type = typeof(CommentDTO))]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult CreateComment([FromBody] CommentDTO commentDTO)
        {
            if (commentDTO == null)
            {
                return BadRequest("Invalid data");
            }

            var date = DateOnly.FromDateTime(DateTime.Today);
            var comments = new Comment()
            {
                CustomerId = commentDTO.CustomerId,
                RestaurantId = commentDTO.RestaurantId,
                Rating = commentDTO.Rating,
                ReviewText = commentDTO.ReviewText,
                CommentDate = date
            };

            _mapper.Map<Comment>(commentDTO);

            if (!_commentRepository.CreateComment(comments))
            {
                return BadRequest("Unable create data in comments");
            }

            var CreatecommentDto = _mapper.Map<CommentDTO>(comments);

            return CreatedAtAction(nameof(GetCommentId), new { id = CreatecommentDto.Id }, CreatecommentDto);
        }

        //put: api/Comments/id
        [HttpPut("update/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult UpdateComment(int id, [FromBody] CommentDTO commentDTO)
        {
            if (commentDTO == null || id != commentDTO.Id)
            {
                return BadRequest("Invalid data");
            }

            if (!_commentRepository.CommentExists(id))
            {
                return NotFound();
            }

            var comment = new Comment()
            {
                Id = commentDTO.Id,
                CustomerId = commentDTO.CustomerId,
                RestaurantId = commentDTO.RestaurantId,
                Rating = commentDTO.Rating,
                ReviewText = commentDTO.ReviewText,
                CommentDate = commentDTO.CommentDate
            };
            _mapper.Map<Comment>(commentDTO);

            if (!_commentRepository.UpdateComment(comment))
            {
                return BadRequest("Unable update data in comments");
            }

            return NoContent();
        }

        //delete: api/Comments/id
        [HttpDelete("delete/{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult DeleteComment(int id)
        {
            if (!_commentRepository.CommentExists(id))
            {
                return NotFound();
            }


            if (!_commentRepository.DeleteComment(id))
            {
                return BadRequest("Unable delete data in comments");
            }

            return NoContent();
        }
    }
}
