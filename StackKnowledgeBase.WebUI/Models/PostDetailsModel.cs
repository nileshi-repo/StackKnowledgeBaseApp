namespace StackKnowledgeBase.WebUI.Models;

public class PostDetailsModel
{
    public int Id { get; set; }
    public int PostTypeId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Body { get; set; } = string.Empty;
    public string DisplayName { get; set; } = string.Empty;
    public DateTime CreationDate { get; set; }
}

