CREATE TABLE [dbo].[PrimeTelemetry_LoggingSession] (
    [LoggingSessionId] INT              IDENTITY (1, 1) NOT NULL,
    [PartitionId]      TINYINT          NOT NULL,
    [LoggerSessionId]  UNIQUEIDENTIFIER NOT NULL,
    [TesterName]       VARCHAR (25)     NULL,
    [CellName]         VARCHAR (50)     NULL,
    [ProgramName]      VARCHAR (50)     NULL,
    [LoadStartTime]    DATETIME         CONSTRAINT [PrimeTelemetry_LoggingSession_LoadStartTimeDefault] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PrimeTelemetry_LoggingSession_PK] PRIMARY KEY CLUSTERED ([LoggingSessionId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_LoggingSession_LoggerSessionId_UI]
    ON [dbo].[PrimeTelemetry_LoggingSession]([LoggerSessionId] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

