CREATE TABLE [dbo].[PrimeTelemetry_LogLevel] (
    [LogLevelId]  INT          IDENTITY (1, 1) NOT NULL,
    [PartitionId] TINYINT      NOT NULL,
    [LogLevel]    VARCHAR (15) NOT NULL,
    CONSTRAINT [PrimeTelemetry_LogLevel_PK] PRIMARY KEY CLUSTERED ([LogLevelId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_LogLevel_UI]
    ON [dbo].[PrimeTelemetry_LogLevel]([LogLevel] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

