SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp__Telemetry_LoadFromStaging] @TempStagingTableName VARCHAR(100)
AS
BEGIN
	
	DECLARE @Staging TABLE 
	(
		[LogEntryId] BIGINT,
		[timestamp] DATETIME,
		[logLevel] VARCHAR(15),
		[logType] VARCHAR(50),
		[area] VARCHAR(150),
		[operationName] VARCHAR(100),
		[startTime] DATETIME,
		[duration] FLOAT,
		[testMethodName] VARCHAR(250),
		[InitExecutionNumber] SMALLINT,
		[globalLoggerSessionId] VARCHAR(50),
		[parameters] VARCHAR(MAX),
		[ActivityId] VARCHAR(100),
		[ParentId] VARCHAR(100),
		[instanceName] VARCHAR(500),
		[dutId] INT,
		[ipId] INT,
		[VPO] VARCHAR(20),
        [Facility] VARCHAR(15),		
		[Operation] VARCHAR(15),
		[ipName] VARCHAR(25),
		[package] VARCHAR(25),
		[bomGroup] VARCHAR(25),
		[testFlow] VARCHAR(25),
		[programName] VARCHAR(50),
		[LotSessionId] VARCHAR(50),
		[DeviceSessionId] VARCHAR(50),
		[TestOrderNumber] INT,
		[UnitId] VARCHAR(50),
		[AgentName] VARCHAR(25),
		[TesterName] VARCHAR(50),
		[CellName] VARCHAR(50),
		[uploadDatetimeUTC] DATETIME,
		
		
		[PartitionId]			TINYINT,
		[LotInTestingSessionId]	INT,
		[LoggingSessionId]		INT,
		[TestMethodNameId]		INT,
		[InstanceNameId]		INT,
		[LogLevelId]			INT,
		[LogTypeId]				INT,
		[AreaId]				INT,
		[LogOperationId]		INT,
		[SessionDutId]			INT

	);

	-- Create a local temp staging table and copy the data into it from the global temp table created from the C# side (eliminates the dynamic sql, can be enhanced in the future to use TVF)
	INSERT INTO @Staging([LogEntryId], [PartitionId], [timestamp], [logLevel], [logType], [area], [operationName], [startTime], [duration], [testMethodName], [InitExecutionNumber], [globalLoggerSessionId], [parameters], [ActivityId], [ParentId], [instanceName], [dutId], [ipId], [VPO], [Facility], [Operation], [ipName], [package], [bomGroup], [testFlow], [programName], [LotSessionId], [DeviceSessionId], [TestOrderNumber], [UnitId], [AgentName], [TesterName], [CellName], [uploadDatetimeUTC]) 
    EXEC (N'SELECT NEXT VALUE FOR [dbo].[Telemetry_LogEntrySequence] AS [LogEntry], [dbo].[Telemetry_GetPartitionIdForTimestamp]([timestamp]) AS [PartitionId], [timestamp], [logLevel], [logType], [area], [operationName], [startTime], [duration], [testMethodName], [InitExecutionNumber], [globalLoggerSessionId], [parameters], [ActivityId], [ParentId], [instanceName], [dutId], [ipId], [VPO], [Facility], [Operation], [ipName], [package], [bomGroup], [testFlow], [programName], [LotSessionId], [DeviceSessionId], [TestOrderNumber], [UnitId], [AgentName], [TesterName], [CellName], [uploadDatetimeUTC] FROM ' + @TempStagingTableName)

	---- Add to [PrimeTelemetry_TestMethodName]
	MERGE	[dbo].[PrimeTelemetry_TestMethodName] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [TestMethodName], [PartitionId]
				FROM	@Staging
				WHERE	[TestMethodName] IS NOT NULL
			) AS SRC([TestMethodName], [PartitionId])
	ON		TRG.[TestMethodName] = SRC.[TestMethodName] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([TestMethodName], [PartitionId])
			VALUES(SRC.[TestMethodName], SRC.[PartitionId]);

	-- Update [TestMethodNameId]
	UPDATE	S
	SET		S.[TestMethodNameId] = TM.[TestMethodNameId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_TestMethodName] TM ON S.[TestMethodName] = TM.[TestMethodName] AND S.[PartitionId] = TM.[PartitionId]



	---- Add to [PrimeTelemetry_InstanceName]
	MERGE	[dbo].[PrimeTelemetry_InstanceName] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [InstanceName], [PartitionId]
				FROM	@Staging
				WHERE	[InstanceName] IS NOT NULL
			) AS SRC([InstanceName], [PartitionId])
	ON		TRG.[InstanceName] = SRC.[InstanceName] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([InstanceName], [PartitionId])
			VALUES(SRC.[InstanceName], SRC.[PartitionId]);

	-- Update [InstanceNameId]
	UPDATE	S
	SET		S.[InstanceNameId] = TI.[InstanceNameId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_InstanceName] TI ON S.[InstanceName] = TI.[InstanceName] AND S.[PartitionId] = TI.[PartitionId]



	---- Add to [PrimeTelemetry_LogLevel]
	MERGE	[dbo].[PrimeTelemetry_LogLevel] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [LogLevel], [PartitionId]
				FROM	@Staging
				WHERE	[LogLevel] IS NOT NULL
			) AS SRC([LogLevel], [PartitionId])
	ON		TRG.[LogLevel] = SRC.[LogLevel] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([LogLevel], [PartitionId])
			VALUES(SRC.[LogLevel], SRC.[PartitionId]);

	-- Update [LogLevelId]
	UPDATE	S
	SET		S.[LogLevelId] = LL.[LogLevelId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_LogLevel] LL ON S.[LogLevel] = LL.[LogLevel] AND S.[PartitionId] = LL.[PartitionId]



	---- Add to [PrimeTelemetry_LogType]
	MERGE	[dbo].[PrimeTelemetry_LogType] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [LogType], [PartitionId]
				FROM	@Staging
				WHERE	[LogType] IS NOT NULL
			) AS SRC([LogType], [PartitionId])
	ON		TRG.[LogType] = SRC.[LogType] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([LogType], [PartitionId])
			VALUES(SRC.[LogType], SRC.[PartitionId]);

	-- Update [LogTypeId]
	UPDATE	S
	SET		S.[LogTypeId] = LT.[LogTypeId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_LogType] LT ON S.[LogType] = LT.[LogType] AND S.[PartitionId] = LT.[PartitionId]



	---- Add to [PrimeTelemetry_Area]
	MERGE	[dbo].[PrimeTelemetry_Area] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [Area], [PartitionId]
				FROM	@Staging
				WHERE	[Area] IS NOT NULL
			) AS SRC([Area], [PartitionId])
	ON		TRG.[Area] = SRC.[Area] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([Area], [PartitionId])
			VALUES(SRC.[Area], SRC.[PartitionId]);

	-- Update [AreaId]
	UPDATE	S
	SET		S.[AreaId] = A.[AreaId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_Area] A ON S.[Area] = A.[Area] AND S.[PartitionId] = A.[PartitionId]



	---- Add to [PrimeTelemetry_LogOperation]
	MERGE	[dbo].[PrimeTelemetry_LogOperation] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [operationName] AS [LogOperation], [PartitionId]
				FROM	@Staging
				WHERE	[operationName] IS NOT NULL
			) AS SRC([LogOperation], [PartitionId])
	ON		TRG.[LogOperation] = SRC.[LogOperation] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([LogOperation], [PartitionId])
			VALUES(SRC.[LogOperation], SRC.[PartitionId]);

	-- Update [LogOperationId]
	UPDATE	S
	SET		S.[LogOperationId] = LO.[LogOperationId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_LogOperation] LO ON S.[operationName] = LO.[LogOperation] AND S.[PartitionId] = LO.[PartitionId]
	


	---- Add to [PrimeTelemetry_DutId]
	MERGE	[dbo].[PrimeTelemetry_DutId] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [DeviceSessionId] AS [LoggerDutId], [PartitionId]
				FROM	@Staging
				WHERE	[DeviceSessionId] IS NOT NULL
			) AS SRC([LoggerDutId], [PartitionId])
	ON		TRG.[LoggerDutId] = SRC.[LoggerDutId] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([LoggerDutId], [PartitionId])
			VALUES(SRC.[LoggerDutId], SRC.[PartitionId]);

	-- Update [SessionDutId]
	UPDATE	S
	SET		S.[SessionDutId] = D.[SessionDutId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_DutId] D ON S.[DeviceSessionId] = D.[LoggerDutId] AND S.[PartitionId] = D.[PartitionId]



	---- Add to [PrimeTelemetry_LoggingSession]
	MERGE	[dbo].[PrimeTelemetry_LoggingSession] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [PartitionId], [globalLoggerSessionId] AS [LoggerSessionId], [TesterName], [CellName], [ProgramName]
				FROM	@Staging
				WHERE	[globalLoggerSessionId] IS NOT NULL						
			) AS SRC([PartitionId], [LoggerSessionId], [TesterName], [CellName], [ProgramName])
	ON		TRG.[LoggerSessionId] = SRC.[LoggerSessionId] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([PartitionId], [LoggerSessionId], [TesterName], [CellName], [ProgramName])
			VALUES(SRC.[PartitionId], SRC.[LoggerSessionId], SRC.[TesterName], SRC.[CellName], SRC.[ProgramName]);

	-- Update [LoggingSessionId]
	UPDATE	S
	SET		S.[LoggingSessionId] = LS.[LoggingSessionId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_LoggingSession] LS ON S.[globalLoggerSessionId] = LS.[LoggerSessionId] AND S.[PartitionId] = LS.[PartitionId]



	---- Add to [PrimeTelemetry_LotInTestingSession]
	MERGE	[dbo].[PrimeTelemetry_LotInTestingSession] WITH (UPDLOCK, ROWLOCK, HOLDLOCK) AS TRG
	USING	(	SELECT	DISTINCT [PartitionId], [LotSessionId] AS [LoggerLotInSessionId], [globalLoggerSessionId] AS [LoggerSessionId], [VPO] AS [Lot], [Operation], [Facility], [Package], [BomGroup], [testFlow] AS [ProcessStep], [InitExecutionNumber]
				FROM	@Staging
				WHERE	[LotSessionId] IS NOT NULL AND
						[VPO] IS NOT NULL
			) AS SRC([PartitionId], [LoggerLotInSessionId], [LoggerSessionId], [Lot], [Operation],[Facility], [Package], [BomGroup], [ProcessStep], [InitExecutionNumber])
	ON		TRG.[LoggerLotInSessionId] = SRC.[LoggerLotInSessionId] AND
			TRG.[PartitionId] = SRC.[PartitionId]
	WHEN NOT MATCHED THEN 
			INSERT([PartitionId], [LoggerLotInSessionId], [LoggerSessionId], [Lot], [Operation],[Facility], [Package], [BomGroup], [ProcessStep], [InitExecutionNumber])
			VALUES(SRC.[PartitionId], SRC.[LoggerLotInSessionId], SRC.[LoggerSessionId], SRC.[Lot], SRC.[Operation],SRC.[Facility], SRC.[Package], SRC.[BomGroup], SRC.[ProcessStep], SRC.[InitExecutionNumber]);

	-- Update [LotInTestingSessionId]
	UPDATE	S
	SET		S.[LotInTestingSessionId] = LTS.[LotInTestingSessionId]
	FROM	@Staging S
	JOIN	[dbo].[PrimeTelemetry_LotInTestingSession] LTS ON S.[LotSessionId] = LTS.[LoggerLotInSessionId] AND S.[PartitionId] = LTS.[PartitionId]
	WHERE	S.[LotSessionId] IS NOT NULL AND
			S.[VPO] IS NOT NULL
	
	-- Add to [dbo].[Telemetry_TestingSessionLogEntry]
	INSERT	INTO [dbo].[PrimeTelemetry_TestingSessionLogEntry]([LogEntryId], [PartitionId], [LotInTestingSessionId], [LoggingSessionId], [LogLevelId], [LogTypeId], [AreaId], [ActivityId], [ParentId], [StartTime], [DurationInMillisecond], [InstanceNameId], [TestMethodNameId], [UltOrVisualId], [DutId], [IpId], [IpName], [WithinSessionDutId], [TestOrderNumber], [LogOperationId])
	SELECT	[LogEntryId], [PartitionId], [LotInTestingSessionId], [LoggingSessionId], [LogLevelId], [LogTypeId], [AreaId], [ActivityId], [ParentId], [StartTime], [duration] AS [DurationInMillisecond], [InstanceNameId], [TestMethodNameId], [UnitId] AS [UltOrVisualId], [DutId], [IpId], [IpName], [SessionDutId] AS [WithinSessionDutId], [TestOrderNumber], [LogOperationId]
	FROM	@Staging
	WHERE	[LoggingSessionId] IS NOT NULL

	-- Add to [dbo].[Telemetry_LotInTestingSessionLogEntry_Parameters]
	INSERT	INTO [dbo].[PrimeTelemetry_TestingSessionLogEntry_Parameters]([LogEntryId], [PartitionId], [Parameters])
	SELECT	[LogEntryId], [PartitionId], [Parameters]
	FROM	@Staging
	WHERE	[LoggingSessionId] IS NOT NULL AND 
			[Parameters] IS NOT NULL

	-- Drop the temp table used to pass the data between the code and SQL
	EXEC (N'DROP TABLE ' + @TempStagingTableName)

END
GO
