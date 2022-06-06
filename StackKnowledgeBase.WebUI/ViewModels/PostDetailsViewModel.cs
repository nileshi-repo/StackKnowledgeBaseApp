using StackKnowledgeBase.WebUI.Models;

namespace StackKnowledgeBase.WebUI.ViewModels;

public class PostDetailsViewModel
{
    private readonly IPostRepository _repo;

    public PostDetailsViewModel(IPostRepository repo)
    {
        _repo = repo;
    }

    public List<PostDetailsModel> GetPostDetailsById(int id)
    {
        List<PostDetailsModel> rtn = new();

        var postDetails = _repo.GetPostDetailsById(id).GetAwaiter().GetResult();

        foreach (var post in postDetails)
        {
            PostDetailsModel p = new()
            {
                Id = post.Id,
                PostTypeId = post.PostTypeId,
                Title = post.Title,
                Body = post.Body,
                DisplayName = post.DisplayName,
                CreationDate = post.CreationDate
            };

            rtn.Add(p);
        }

        return rtn;
    }
}
