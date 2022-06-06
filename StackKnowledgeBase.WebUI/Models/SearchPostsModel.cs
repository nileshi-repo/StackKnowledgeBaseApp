namespace StackKnowledgeBase.WebUI.Models;

public class SearchPostsModel
{
    public int SearchRank { get; set; }
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Body { get; set; } = string.Empty;
    public int TotalVotes { get; set; }
    public int TotalAnswers { get; set; }
    public int OwnerUserId { get; set; }
    public string DisplayName { get; set; } = string.Empty;
    public int Reputation { get; set; }
    public string UserBadges { get; set; } = string.Empty;

}
