-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
/*


*/
CREATE PROCEDURE [dbo].[GetIdsidsNeededUpdateInfo]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [UserSessions].[idsid]
	FROM [dbo].[UserSessions]
	LEFT JOIN [dbo].[TraceUsersInfo] ON [UserSessions].[idsid] = [TraceUsersInfo].[idsid]
	WHERE [TraceUsersInfo].[idsid] IS NULL and [UserSessions].[idsid] != ''
	

END

GO

