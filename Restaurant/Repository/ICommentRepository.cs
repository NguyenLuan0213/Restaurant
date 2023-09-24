using Restaurant.Models;

namespace Restaurant.Repository
{
    public interface ICommentRepository
    {
        ICollection<Comment> GetComments();
        Comment GetCommentById(int id);
        Comment GetCommentByRating(int rating);
        Comment GetCommentByReviewText(string reviewText);
        Comment GetCommentByCommentDate(DateOnly commentDate);
        ICollection<Comment> GetCommentsByCustomerId(int customerId);
        ICollection<Comment> GetCommentsByRestaurantId(int restaurantId);
        ICollection<Comment> GetCommentsByCommentDate(DateOnly commentDate);
        ICollection<Comment> GetCommentsByRating(int rating);

        bool CreateComment(Comment comment);
        bool UpdateComment(Comment comment);
        bool DeleteComment(int id);
        bool Save();
        bool CommentExists(int id);
    }
}
