using StackKnowledgeBase.WebUI.Helpers;
using StackKnowledgeBase.WebUI.Models;

namespace StackKnowledgeBase.WebUI.ViewModels;

public class SearchPostsWPagerViewModel
{
    private readonly IPostRepository _repo;
    private readonly IConfiguration _config;
    private readonly HttpContext? _context;
    private const string SessionKeySearchText = "_SearchText";
    private const string SessionKeyPagerInfo = "_PagerInfo";
    public SearchPostsWPagerViewModel(IPostRepository repo, IConfiguration config, HttpContext? context)
    {
        _repo = repo;
        _config = config;
        if (context != null)
        {
            _context = context;
        }
    }

    public SearchPostsWPagerModel GetPosts(string? searchString, int pageNum)
    {
        SearchPostsWPagerModel rtn = new();

        if ((string.IsNullOrEmpty(searchString) && pageNum == 0) || (_context == null))
        {
            return rtn;
        }

        if (!string.IsNullOrEmpty(searchString))
        {
            _context.Session.Clear();
            _context.Session.SetString(SessionKeySearchText, searchString);
            int totalRecords = _repo.GetPostCountBySearchtext(searchString).GetAwaiter().GetResult();

            if (totalRecords == 0)
            {
                return rtn;
            }

            int pageSize = _config.GetValue<int>("ResultsPerPage");
            rtn.PagerInfo = new(totalRecords, pageSize);
            rtn.PagerInfo.StartIndex = 1;
            rtn.PagerInfo.EndIndex = (rtn.PagerInfo.TotalPages < rtn.PagerInfo.MaxPages) ? rtn.PagerInfo.TotalPages : rtn.PagerInfo.MaxPages;
        }
        else
        {
            searchString = _context.Session.GetString(SessionKeySearchText) ?? string.Empty;
            var prevPagerInfo = _context.Session.GetObject<Pager>(SessionKeyPagerInfo);

            if (string.IsNullOrEmpty(searchString) || (prevPagerInfo == null))
            {
                return rtn;
            }

            rtn.PagerInfo = prevPagerInfo.SetPagerInfo(pageNum);
        }

        int offset = (rtn.PagerInfo.CurrentPage - 1) * rtn.PagerInfo.PageSize;
        var posts = _repo.GetPostsBySearchtext(searchString, offset, rtn.PagerInfo.PageSize).GetAwaiter().GetResult();

        foreach (var post in posts)
        {
            SearchPostsModel vm = new()
            {
                Id = post.Id,
                Title = post.Title,
                Body = post.Body,
                TotalVotes = post.TotalVotes,
                TotalAnswers = post.TotalAnswers,
                OwnerUserId = post.OwnerUserId,
                DisplayName = post.DisplayName,
                Reputation = post.Reputation,
                UserBadges = post.UserBadges
            };

            rtn.PostsList.Add(vm);
        }

        _context.Session.SetObject(SessionKeyPagerInfo, rtn.PagerInfo);

        return rtn;
    }

}
