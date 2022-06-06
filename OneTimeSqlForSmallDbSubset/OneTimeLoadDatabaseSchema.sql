/****** Object:  FullTextCatalog [ftPostsCatalog]    Script Date: 5/22/2022 12:45:51 PM ******/
CREATE FULLTEXT CATALOG [ftPostsCatalog] WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
GO
/****** Object:  Table [dbo].[Badges]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Badges](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[UserId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Badges__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL,
	[Score] [int] NULL,
	[Text] [nvarchar](700) NOT NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_Comments__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LinkTypes]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LinkTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LinkTypes__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostLinks]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostLinks](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[PostId] [int] NOT NULL,
	[RelatedPostId] [int] NOT NULL,
	[LinkTypeId] [int] NOT NULL,
 CONSTRAINT [PK_PostLinks__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AcceptedAnswerId] [int] NULL,
	[AnswerCount] [int] NULL,
	[Body] [nvarchar](max) NOT NULL,
	[ClosedDate] [datetime] NULL,
	[CommentCount] [int] NULL,
	[CommunityOwnedDate] [datetime] NULL,
	[CreationDate] [datetime] NOT NULL,
	[FavoriteCount] [int] NULL,
	[LastActivityDate] [datetime] NOT NULL,
	[LastEditDate] [datetime] NULL,
	[LastEditorDisplayName] [nvarchar](40) NULL,
	[LastEditorUserId] [int] NULL,
	[OwnerUserId] [int] NULL,
	[ParentId] [int] NULL,
	[PostTypeId] [int] NOT NULL,
	[Score] [int] NOT NULL,
	[Tags] [nvarchar](150) NULL,
	[Title] [nvarchar](250) NULL,
	[ViewCount] [int] NOT NULL,
 CONSTRAINT [PK_Posts__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PostTypes]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PostTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PostTypes__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AboutMe] [nvarchar](max) NULL,
	[Age] [int] NULL,
	[CreationDate] [datetime] NOT NULL,
	[DisplayName] [nvarchar](40) NOT NULL,
	[DownVotes] [int] NOT NULL,
	[EmailHash] [nvarchar](40) NULL,
	[LastAccessDate] [datetime] NOT NULL,
	[Location] [nvarchar](100) NULL,
	[Reputation] [int] NOT NULL,
	[UpVotes] [int] NOT NULL,
	[Views] [int] NOT NULL,
	[WebsiteUrl] [nvarchar](200) NULL,
	[AccountId] [int] NULL,
 CONSTRAINT [PK_Users_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Votes]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Votes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PostId] [int] NOT NULL,
	[UserId] [int] NULL,
	[BountyAmount] [int] NULL,
	[VoteTypeId] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Votes__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VoteTypes]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VoteTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_VoteType__Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IDX_Badges__UserId]    Script Date: 5/22/2022 12:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Badges__UserId] ON [dbo].[Badges]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_Posts__ParentId]    Script Date: 5/22/2022 12:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Posts__ParentId] ON [dbo].[Posts]
(
	[ParentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IDX_Votes__PostId]    Script Date: 5/22/2022 12:45:51 PM ******/
CREATE NONCLUSTERED INDEX [IDX_Votes__PostId] ON [dbo].[Votes]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  FullTextIndex     Script Date: 5/22/2022 12:45:51 PM ******/
CREATE FULLTEXT INDEX ON [dbo].[Posts](
[Body] LANGUAGE 'English', 
[Tags] LANGUAGE 'English', 
[Title] LANGUAGE 'English')
KEY INDEX [PK_Posts__Id]ON ([ftPostsCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)

GO
/****** Object:  StoredProcedure [dbo].[DropIndexes]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[DropIndexes] 
  @SchemaName NVARCHAR(255) = 'dbo', @TableName NVARCHAR(255) = NULL AS
BEGIN
SET NOCOUNT ON

CREATE TABLE #commands (ID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED, Command NVARCHAR(2000));
DECLARE @CurrentCommand NVARCHAR(2000);

INSERT INTO #commands (Command)
SELECT 'DROP INDEX [' + i.name + '] ON [' + SCHEMA_NAME(t.schema_id) + '].[' + t.name + ']'
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
WHERE i.type = 2
AND SCHEMA_NAME(t.schema_id) = COALESCE(@SchemaName, SCHEMA_NAME(t.schema_id))
AND t.name = COALESCE(@TableName, t.name);

INSERT INTO #commands (Command)
SELECT 'DROP STATISTICS ' + SCHEMA_NAME(t.schema_id) + '.'  + OBJECT_NAME(s.object_id) + '.' + s.name
FROM sys.stats AS s
INNER JOIN sys.tables AS t ON s.object_id = t.object_id
WHERE NOT EXISTS (SELECT * FROM sys.indexes AS i WHERE i.name = s.name) 
AND SCHEMA_NAME(t.schema_id) = COALESCE(@SchemaName, SCHEMA_NAME(t.schema_id))
AND t.name = COALESCE(@TableName, t.name)
AND OBJECT_NAME(s.object_id) NOT LIKE 'sys%';
DECLARE result_cursor CURSOR FOR
SELECT Command FROM #commands

OPEN result_cursor
FETCH NEXT FROM result_cursor into @CurrentCommand
WHILE @@FETCH_STATUS = 0
BEGIN 
        
        PRINT @CurrentCommand;
	EXEC(@CurrentCommand);

FETCH NEXT FROM result_cursor into @CurrentCommand
END
--end loop

--clean up
CLOSE result_cursor
DEALLOCATE result_cursor
END
GO
/****** Object:  StoredProcedure [dbo].[spGetPostCountBySearchText]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPostCountBySearchText]
	@SearchText  NVARCHAR(200)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT count(*) as TotalCount
	  FROM Posts AS pa
		INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
		INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT_TBL ON pa.Id = FT_TBL.[KEY]
	 WHERE pa.PostTypeId = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetPostDetailsText]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPostDetailsText]
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
GO
/****** Object:  StoredProcedure [dbo].[spGetPostsBySearchText]    Script Date: 5/22/2022 12:45:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPostsBySearchText]
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
		(SELECT CONVERT(nvarchar(max), b.Name + ',') FROM Badges b
		  WHERE b.UserId = pa.OwnerUserId ORDER BY b.Date desc
		  FOR XML PATH('') ) as UserBadges
	  FROM Posts AS pa
		INNER JOIN Users AS usr ON pa.OwnerUserId = usr.Id
		INNER JOIN FREETEXTTABLE (Posts, (Body, Title, Tags), @SEARCHTEXT) AS FT_TBL ON pa.Id = FT_TBL.[KEY]
	 WHERE pa.PostTypeId = 1
	 ORDER BY FT_TBL.RANK DESC
	 OFFSET @OffsetCount ROWS FETCH NEXT @SelectCount ROWS ONLY;
END;
GO
