namespace StackKnowledgeBase.WebUI.Helpers;

public class Pager
{
    public int TotalRecords { get; private set; }
    public int TotalPages { get; private set; }
    public int PageSize { get; private set; }
    public int MaxPages { get; private set; }
    public int CurrentPage { get; set; }
    public int StartIndex { get; set; }
    public int EndIndex { get; set; }

    public Pager(int totalRecords, int pageSize, int maxPages = 10)
    {
        TotalRecords = totalRecords;
        PageSize = (pageSize == 0) ? 10 : pageSize;
        MaxPages = maxPages;
        TotalPages = (int)Math.Ceiling((decimal)TotalRecords / PageSize);
        CurrentPage = 1;
        StartIndex = 1;
        EndIndex = MaxPages;
    }

    public Pager SetPagerInfo(int pgNum)
    {
        Pager pager = new(TotalRecords, PageSize, MaxPages);
        pager.TotalPages = TotalPages;
        pager.CurrentPage = (pgNum < 1) ? 1 : (pgNum > pager.TotalPages) ? pager.TotalPages : pgNum;
        pager.StartIndex = (((int)Math.Floor((pager.CurrentPage - 1) / (decimal)pager.PageSize)) * pager.PageSize) + 1;
        pager.EndIndex = (pager.StartIndex - 1 + pager.MaxPages) >= pager.TotalPages
            ? pager.TotalPages
            : (pager.StartIndex - 1 + pager.MaxPages);
        return pager;
    }
}
