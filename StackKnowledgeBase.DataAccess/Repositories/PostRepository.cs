using StackKnowledgeBase.DataAccess.DbAccess;
using StackKnowledgeBase.DataAccess.Entities;

namespace StackKnowledgeBase.DataAccess.Repositories;

public class PostRepository : IPostRepository
{
    private readonly ISqlDataAccess _db;

    public PostRepository(ISqlDataAccess db)
    {
        _db = db;
    }

    public async Task<int> GetPostCountBySearchtext(string searchtext)
    {
        var obj = await _db.LoadData<int, dynamic>("dbo.spGetPostCountBySearchText",
                                                   'S',
                                                   new { searchtext });
        return obj.FirstOrDefault();

        #region Stored Procedure Query (FYI)
        /* Query used for spGetPostCountBySearchText

	       SELECT count(*) as TotalCount
	         FROM Posts AS pa
	                INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
	       	        INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT_TBL ON pa.Id = FT_TBL.[KEY]
	        WHERE pa.PostTypeId = 1;
         */
        #endregion
    }

    public async Task<IEnumerable<SearchPostDbModel>> GetPostsBySearchtext(string searchtext, int offsetCount, int selectCount)
    {
        var obj = await _db.LoadData<SearchPostDbModel, dynamic>("dbo.spGetPostsBySearchText",
                                                   'S',
                                                   new { searchtext, offsetCount, selectCount });
        return obj;

        #region Stored Procedure Query (FYI)
        /* Query used for spGetPostsBySearchText

           SELECT FT_TBL.RANK as SearchRank,
		             pa.Id,
		             pa.Title,
		             pa.Body,
		             (SELECT count(*) FROM Votes WHERE PostId = pa.Id) as TotalVotes,
		             (SELECT count(*) FROM Posts pb WHERE pb.ParentId = pa.Id AND pb.PostTypeId = 2) as TotalAnswers,
		             pa.OwnerUserId,
		             usr.DisplayName,
		             usr.Reputation,
		             (SELECT CONVERT(nvarchar(max), b.Name + ',') FROM Badges b
		               WHERE b.UserId = pa.OwnerUserId ORDER BY b.Date desc
		               FOR XML PATH('') ) as UserBadges
	          FROM Posts AS pa
		             INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
		             INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT_TBL ON pa.Id = FT_TBL.[KEY]
	         WHERE pa.PostTypeId = 1
	         ORDER BY FT_TBL.RANK DESC
	         OFFSET @OffsetCount ROWS FETCH NEXT @SelectCount ROWS ONLY;
         */
        #endregion
    }

    public async Task<IEnumerable<PostDetailsDbModel>> GetPostDetailsById(int postId)
    {
        var obj = await _db.LoadData<PostDetailsDbModel, dynamic>("dbo.spGetPostDetailsText",
                                                   'S',
                                                   new { postId });
        return obj;

        #region Stored Procedure Query (FYI)
        /* Query used for spGetPostDetailsText

	       SELECT a.Id,
	          	  a.PostTypeId,
	          	  a.ParentId,
	          	  a.OwnerUserId,
	          	  a.Title,
	          	  a.Body,
	          	  b.DisplayName,
	          	  a.CreationDate
	         FROM Posts a,
	           	  Users b
	        WHERE (a.Id = @PostId OR a.ParentId = @PostId)
	          AND a.OwnerUserId = b.Id
	        ORDER BY a.PostTypeId, a.Id;
         */
        #endregion
    }

}
