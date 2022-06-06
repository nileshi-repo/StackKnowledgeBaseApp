using StackKnowledgeBase.WebUI.Helpers;

namespace StackKnowledgeBase.WebUI.Models;

public class SearchPostsWPagerModel
{
    public List<SearchPostsModel> PostsList { get; set; } = new List<SearchPostsModel>();
    public Pager? PagerInfo { get; set; }
}
