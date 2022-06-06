## StackKnowledgeBaseApp

This is .NET Core MVC app that uses free available version of “StackOverflow.com” database and searches StackOverflow posts for any text entered by user.<br>
This project is created to explore FULL TEXT search feature in SQL server and use of Dapper in .NET Core MVC App.<br>
This is a responsive website and works well on mobile as well.

Follow steps below to explore and use this application –
1. (1A) Download and setup a copy of the StackOverflow.com database locally. This SMALL (10GB) database contains data of posts, users, votes, badges, etc.<br>
    <https://www.brentozar.com/archive/2015/10/how-to-download-the-stack-overflow-database-via-bittorrent>

   Click [here](#data-model-details) for Data Model details.
    
   Refer this external [link](https://stackoverflow.com/questions/4037908/sql-server-importing-database-from-mdf#:~:text=In%20the%20'Object%20Explorer'%20window,database%20and%20you%20are%20done.) for information on how to load MDF file.
   
   **OR**
   
    (1B) If you do not want to copy entire 10 GB database, you can create a smaller subset of it for quick testing purpose. Follow steps [here](#steps-to-create-small-subset-of-db).\
    **Note** *- Step 2 is not required if you follow this approach. However, do read the details on indexes and stored procedures used here.*


  2. Add DB indexes and stored procedures in database. See detailed steps [here](#add-db-indexes-and-stored-procedures). *(This step is not needed if you have followed step 1B.)*
  3. Clone the GitHub repository.
  4. Update SQL connection string for *StackDbConnection* in *appsettings.json*
  5. Build and run the application.
  6. Click [here](#solution-and-app-screenshots) for more details on solution and application screenshots.
  7. You can see the demo [here](https://stackknowledgebase.azurewebsites.net/). Website deployed on Azure with smaller version of above database (Copied data related to first 10,000 posts only).

<br>

***

### Steps to Create Small Subset of DB

<details>
    <summary markdown="span">Click to expand/collapse</summary>

1.	Refer to [One Time Data SQLs](/OneTimeSqlForSmallDbSubset)

2.	First run [`OneTimeLoadDatabaseSchema.sql`](/OneTimeSqlForSmallDbSubset/OneTimeLoadDatabaseSchema.sql). It creates database tables, indexes, and stored procedures.

3.	Then run following queries that add data to the tables –
    <pre>
    <code>
    i.    <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Badges.Table_1.sql">dbo.Badges.Table_1.sql</a>
    ii.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Badges.Table_2.sql">dbo.Badges.Table_2.sql</a>
    iii.  <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Comments.Table.sql">dbo.Comments.Table.sql</a>
    iv.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.LinkTypes.Table.sql">dbo.LinkTypes.Table.sql</a>
    v.    <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.PostLinks.Table.sql">dbo.PostLinks.Table.sql</a>
    vi.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Posts.Table.sql">dbo.Posts.Table.sql</a>
    vii.  <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.PostTypes.Table.sql">dbo.PostTypes.Table.sql</a>
    viii. <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_1.sql">dbo.Users.Table_1.sql</a>
    ix.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_2.sql">dbo.Users.Table_2.sql</a>
    x.    <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_3.sql">dbo.Users.Table_3.sql</a>
    xi.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_4.sql">dbo.Users.Table_4.sql</a>
    xii.  <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_5.sql">dbo.Users.Table_5.sql</a>
    xiii. <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Users.Table_6.sql">dbo.Users.Table_6.sql</a>
    xiv.  <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.Votes.Table.sql">dbo.Votes.Table.sql</a>
    xv.   <a href="https://github.com/nileshi-repo/StackKnowledgeBaseApp/blob/master/OneTimeSqlForSmallDbSubset/dbo.VoteTypes.Table.sql">dbo.VoteTypes.Table.sql</a>
    </code>
    </pre>
4.	Finally, run [`RebuildAllIndexesDB.sql`](/OneTimeSqlForSmallDbSubset/RebuildAllIndexesDB.sql) to rebuild all the indexes. Make sure to add your *Azure Database Name* in this script on line 8.

5.	This creates a smaller subset of database with 10,000 posts in Posts table.
 
<br>

[Back to high level steps](#stackknowledgebaseapp)

</details>
    
***

### Add DB Indexes and Stored Procedures
<details>
    <summary markdown="span">Click to expand/collapse</summary>

#### 1. Run following queries in database for performance improvement.
   ```sql
   CREATE FULLTEXT CATALOG ftPostsCatalog AS DEFAULT;

   CREATE FULLTEXT INDEX ON dbo.Posts(Body LANGUAGE 1033, Title LANGUAGE 1033, Tags LANGUAGE 1033) KEY INDEX PK_Posts__Id ON ftPostsCatalog;

   CREATE INDEX IDX_Votes__PostId ON dbo.Votes(PostId);

   CREATE INDEX IDX_Posts__ParentId ON dbo.Posts(ParentId);

   CREATE INDEX IDX_Badges__UserId ON dbo.Badges(UserId);
   ```

#####   Few points to note:
   - If you do not have full text feature installed in SQL Server, it must be installed. SQL server allows to create full text catalog but gives “*Full-Text Search is not installed, or a full-text component cannot be loaded*” error if the feature is not installed.\
Refer this external [link](https://stackoverflow.com/questions/47437742/full-text-search-is-not-installed-or-a-full-text-component-cannot-be-loaded) about this error and instructions on how to install full text feature.
   - Make sure to create CATALOG before creating index
   - Make sure to use Primary Index ***Name*** (not primary key) while creating full-text index

<br>

#### 2. Create stored procedure to get matching posts based on search text.
   ```sql
    CREATE PROCEDURE dbo.spGetPostsBySearchText
        @SearchText  NVARCHAR(200),
        @OffsetCount INT,
        @SelectCount INT
    AS
    BEGIN
          SET NOCOUNT ON
          SELECT FT_TBL.RANK as SearchRank,
                 pa.Id,
                 pa.Title,
                 pa.Body,
                 (SELECT count(*) FROM Votes WHERE PostId = pa.Id) as TotalVotes,
                 (SELECT count(*) FROM Posts pb WHERE pb.ParentId = pa.Id AND pb.PostTypeId = 2) as TotalAnswers,
                 pa.OwnerUserId,
                 usr.DisplayName,
                 usr.Reputation,
                 ( SELECT CONVERT(nvarchar(max), b.Name + ',') FROM Badges b
                   WHERE b.UserId = pa.OwnerUserId ORDER BY b.Date desc
                   FOR XML PATH('')
                 ) as UserBadges
          FROM Posts AS pa
                 INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
                 INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT_TBL ON pa.Id = FT_TBL.[KEY]
         WHERE pa.PostTypeId = 1
         ORDER BY FT_TBL.RANK DESC
        OFFSET @OffsetCount ROWS FETCH NEXT @SelectCount ROWS ONLY;
   END;
   ```

   - This procedure extracts all the fields required to show on search posts panel.
   - It takes 3 arguments – search string, offset and how may records to select.
   - It sorts data on RANK.
   - FREETEXTTABLE creates a weighted rank based on how strongly the search string matches. 


##### Reason for using FULLTEXT index
- User can put any values in search field. For ex. If user puts “C# .NET sql” in search bar it should search on all 3 keywords and find posts with maximum matches to find most relevant posts for user.
- FREETEXT index works best for all that. Also, it is not case-sensitive.
- It searches for pattern in 3 columns Body, Title, Tags.
- Query performance is very good. Mostly returned results in less than 20 seconds during my testing.


##### Reason for secondary indexes on *dbo.Votes(PostId), dbo.Posts(ParentId), dbo.Badges(UserId)* –
- These given columns are used in stored procedure joins. Their primary key is indexed but search is performed based on other fields as well. So having these secondary indexes improves performance of stored procedure.

<br>
 
#### 3. Create stored procedure to get post count for search text.
   ```sql
    CREATE PROCEDURE dbo.spGetPostCountBySearchText
           @SearchText  NVARCHAR(200)
    AS
    BEGIN
         SET NOCOUNT ON
         SELECT count(*) as TotalCount
           FROM Posts AS pa
                  INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
                  INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT\_TBL ON pa.Id = FT\_TBL.[KEY]
          WHERE pa.PostTypeId = 1;
    END;
   ```

- It takes 1 argument – search string and returns the total count of posts matching with “search text”

<br>

#### 4. Create stored procedure to get post details from post id
   ```sql
    CREATE PROCEDURE dbo.spGetPostDetailsText
           @PostId  INT
    AS
    BEGIN
        SET NOCOUNT ON
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
    END;
   ```

- It takes 1 argument – post id.

<br>

[Back to high level steps](#stackknowledgebaseapp)

</details>
    
***

### Solution and App Screenshots

The solution has 2 projects.
1. **StackKnowledgeBase.DataAccess** – This gets data from database. Used Dapper for data access.
2. **StackKnowledgeBase.WebUI** - .NET Core 6.0 MVC Application

    #### Screenshots
<details>
        <summary markdown="span">Click to expand/collapse</summary>

### Desktop View    
**Home Page**

|![Home Page](/Documentation/Demo%20Screenshots/HomePage.png "Home Page")|
| --- |

##
    
**Adding Search Text**
|![Add Search Text](/Documentation/Demo%20Screenshots/AddSearchText.png "Add Search Text")|
| --- |

##
    
**Clicking on Search Button**
1.	Gets the search results (10 records)
2.	Shows fetched data.
3.	Shows total questions, total pages, and search text
4.	Shows page numbers to select. Shows on top and bottom, so that the user has flexibility.
5.	Current page is highlighted blue

|![Click Search Button](/Documentation/Demo%20Screenshots/SearchResultPage.png "Search Result Page")|
| --- |


**Each Record Detailed View**
1. For each record it shows – \
   a. Post Title \
   b. Maximum of 140 characters from the Description \
   c. Total # of Votes \
   d. Total # of Answers \
   e. The User who asked the question along with their reputation score

    
|![Each Record Detailed View](/Documentation/Demo%20Screenshots/SearchRecordDetailedView.png "Each Record Detailed View")|
| --- |
    
##
    
**Page Number Click** - When any page number is clicked, data on that page is shown.
- Notice changes in URL.
- Notice the clicked page number is highlighted.

|![Page Number Click](/Documentation/Demo%20Screenshots/PageNumberClick.png "Page Number Click")|
| --- |

##

**Click on next button “>>”**
- Shows next 10 pages (in this screenshot shows pages from 11-20).
- Notice previous button “<<”. This was not available on screen with page 1.
- Currently it shows 10 pages to select but it can be easily customized to show more or less pages, as needed.

|![Next Button Click](/Documentation/Demo%20Screenshots/NextArrowClick.png "Next Button Click")|
| --- |

##

**Last Page**
- Shows pages from 331-337
- Notice next button “>>” is not available on the screen with last page.

|![Last Page](/Documentation/Demo%20Screenshots/LastPage.png "Last Page")|
| --- |

##

**Click on previous button “<<”**
- Shows previous 10 pages (in this screenshot shows pages from 321-330).

|![Previous Button Click](/Documentation/Demo%20Screenshots/PrevArrowClick.png "Previous Button Click")|
| --- |

##

**Passing 0 or Negative Page Number in URL**
- Passing 0 or negative page number in URL, brings back to page 1.
- Notice “-2” in URL.

|![Zero Or Negative Page Number](/Documentation/Demo%20Screenshots/ZeroOrNegativePageNumber.png "Zero Or Negative Page Number")|
| --- |

##

**Passing Very High Page Number in URL**
- Passing very high page number in URL that is not available, takes to the last page.
- Notice “400000” in URL.

|![Extremely High Page Number](/Documentation/Demo%20Screenshots/ExtremelyHighPageNumber.png "Extremely High Page Number")|
| --- |
    
##

**Searching Different Words** \
**Search "Unix"**

|![Search Diff Text 1](/Documentation/Demo%20Screenshots/SearchDiffText1.png "Search Diff Text 1")|
| --- |

##

**Search "John"**

|![Search Diff Text 2](/Documentation/Demo%20Screenshots/SearchDiffText2.png "Search Diff Text 2")|
| --- |

##
    
**Search "abcdghy"**

|![Search Diff Text 3](/Documentation/Demo%20Screenshots/SearchDiffText3.png "Search Diff Text 3")|
| --- |

##
    
**Search Special Character - "double quotes ("")"**

|![Search Diff Text 4](/Documentation/Demo%20Screenshots/SearchDiffText4.png "Search Diff Text 4")|
| --- |

##

**Click on search button without putting any search text in textbox**
- Shows pop-up for user to fill the data.

|![Click Search When No Search Text](/Documentation/Demo%20Screenshots/ClickSearchWhenNoSearchText.png "Click Search When No Search Text")|
| --- |

##

**Post Detail Page** - Clicking on a Post Title opens that post

|![Post Detail Page](/Documentation/Demo%20Screenshots/PostDetailPage.png "Post Detail Page")|
| --- |

##

### Mobile View

**Home Page**

|![Moblie View Home Page](/Documentation/Demo%20Screenshots/MV_HomePage.png "Moblie View Home Page")|
| --- |

##

**No Search Text**

|![Moblie View No Search Text](/Documentation/Demo%20Screenshots/MV_NoSearchText.png "Moblie View No Search Text")|
| --- |

##

**Search Results Page**

|![Moblie View Search Results Page](/Documentation/Demo%20Screenshots/MV_SearchResultPage.png "Moblie View Search Results Page")|
| --- |

##

**Search Results Bottom of The Page** - bottom of the search results page after scrolling

|![Moblie View Search Results Page Bottom](/Documentation/Demo%20Screenshots/MV_SearchResultPageBottom.png "Moblie View Search Results Page Bottom")|
| --- |

##

**Post Detail Page** - Clicking on a Post Title opens that post \

|![Moblie View Post Detail Page](/Documentation/Demo%20Screenshots/MV_PostDetailPage.png "Moblie View Post Detail Page")|
| --- |

##

</details>

[Back to high level steps](#stackknowledgebaseapp)

***

### Data Model Details

Refer [ReadMe.docx](/Documentation/ReadMe.docx) for data model details.

[Back to high level steps](#stackknowledgebaseapp)

***
