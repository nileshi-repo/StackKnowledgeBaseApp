using StackKnowledgeBase.DataAccess.Entities;

namespace StackKnowledgeBase.DataAccess.Repositories;

public interface IPostRepository
{
    Task<int> GetPostCountBySearchtext(string searchtext);
    Task<IEnumerable<SearchPostDbModel>> GetPostsBySearchtext(string str, int offsetCnt, int selectCnt);
    Task<IEnumerable<PostDetailsDbModel>> GetPostDetailsById(int id);
}
