using Microsoft.AspNetCore.Mvc;
using StackKnowledgeBase.WebUI.ViewModels;
using System.Diagnostics;

namespace StackKnowledgeBase.WebUI.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;
    private readonly IPostRepository _repo;
    private readonly IConfiguration _config;
    private readonly IHttpContextAccessor _httpContextAccessor;
    public HomeController(
        ILogger<HomeController> logger,
        IPostRepository repo,
        IConfiguration config,
        IHttpContextAccessor httpContextAccessor
        )
    {
        _logger = logger;
        _repo = repo;
        _config = config;
        _httpContextAccessor = httpContextAccessor;
    }

    public IActionResult Index()
    {
        return View();
    }

    [HttpGet]
    [ResponseCache(Duration = 120)]
    public IActionResult SearchPosts(string? searchString, int pageNum = 0)
    {
        SearchPostsWPagerViewModel postsVM = new(_repo, _config, _httpContextAccessor.HttpContext);
        return View(postsVM.GetPosts(searchString, pageNum));
    }

    [HttpGet]
    [ResponseCache(Duration = 120)]
    public IActionResult PostDetails(int id)
    {
        PostDetailsViewModel postDtlsVM = new(_repo);
        var post = postDtlsVM.GetPostDetailsById(id);
        return View(post);
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}
