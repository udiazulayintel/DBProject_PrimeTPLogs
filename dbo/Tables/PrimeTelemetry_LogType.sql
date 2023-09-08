CREATE TABLE [dbo].[PrimeTelemetry_LogType] (
    [LogTypeId]   INT          IDENTITY (1, 1) NOT NULL,
    [PartitionId] TINYINT      NOT NULL,
    [LogType]     VARCHAR (15) NOT NULL,
    CONSTRAINT [PrimeTelemetry_LogType_PK] PRIMARY KEY CLUSTERED ([LogTypeId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_LogType_UI]
    ON [dbo].[PrimeTelemetry_LogType]([LogType] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

