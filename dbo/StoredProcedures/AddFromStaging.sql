-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE AddFromStaging
(
	@TempTableName varchar(50)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--EXEC 'INSERT INTO PrimeTPLogs SELECT * FROM'

	DECLARE @sql AS NVARCHAR(200)	
	SELECT @sql = 'INSERT INTO [dbo].[PrimeLogs] SELECT * FROM ' + @TempTableName + ';'
	EXEC(@SQL)

	SELECT @sql = 'DROP TABLE ' + @TempTableName + ';'
	EXEC(@SQL)
	
END

GO

