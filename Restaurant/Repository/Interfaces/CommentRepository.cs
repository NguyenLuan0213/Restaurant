using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class CommentRepository : ICommentRepository
    {
        private readonly RestaurantContext _context;

        public CommentRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool CommentExists(int id)
        {
            return _context.Comments.Any(c => c.Id == id);
        }

        public bool CreateComment(Comment comment)
        {
            try
            {
                _context.Comments.Add(comment);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteComment(int id)
        {
            var commentToDelete = _context.Comments.FirstOrDefault(c => c.Id == id);
            if (commentToDelete == null)
            {
                return false;
            }

            try
            {
                _context.Comments.Remove(commentToDelete);
                _context.SaveChanges();

                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public Comment GetCommentByCommentDate(DateOnly commentDate)
        {
            return _context.Comments.Where(c => c.CommentDate == commentDate).FirstOrDefault();
        }
        public Comment GetCommentById(int id)
        {
            return _context.Comments.Where(c => c.Id == id).FirstOrDefault();
        }

        public Comment GetCommentByRating(int rating)
        {
            return _context.Comments.Where(c => c.Rating == rating).FirstOrDefault();
        }

        public Comment GetCommentByReviewText(string reviewText)
        {
            return _context.Comments.Where(c => c.ReviewText == reviewText).FirstOrDefault();
        }

        public ICollection<Comment> GetComments()
        {
            return _context.Comments.OrderBy(c => c.Id).ToList();
        }

        public ICollection<Comment> GetCommentsByCommentDate(DateOnly commentDate)
        {
            return _context.Comments.Where(c => c.CommentDate == commentDate).ToList();
        }

        public ICollection<Comment> GetCommentsByCustomerId(Guid customerId)
        {
            return _context.Comments.Where(c => c.CustomerId == customerId).ToList();
        }

        public ICollection<Comment> GetCommentsByRating(int rating)
        {
            return _context.Comments.Where(c => c.Rating == rating).ToList();
        }

        public ICollection<Comment> GetCommentsByRestaurantId(int restaurantId)
        {
            return _context.Comments.Where(c => c.RestaurantId == restaurantId).ToList();
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool UpdateComment(Comment comment)
        {
            try
            {
                var commentToUpdate = _context.Comments.Where(c => c.Id == comment.Id).FirstOrDefault();

                if (commentToUpdate != null)
                {
                    commentToUpdate.CommentDate = comment.CommentDate;
                    commentToUpdate.CustomerId = comment.CustomerId;
                    commentToUpdate.Rating = comment.Rating;
                    commentToUpdate.RestaurantId = comment.RestaurantId;
                    commentToUpdate.ReviewText = comment.ReviewText;
                    _context.SaveChanges();
                    return true;

                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
