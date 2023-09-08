CREATE TABLE [dbo].[PrimeTelemetry_LogOperation] (
    [LogOperationId] INT           IDENTITY (1, 1) NOT NULL,
    [PartitionId]    TINYINT       NOT NULL,
    [LogOperation]   VARCHAR (100) NOT NULL,
    CONSTRAINT [PrimeTelemetry_LogOperation_PK] PRIMARY KEY CLUSTERED ([LogOperationId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_LogOperation_UI]
    ON [dbo].[PrimeTelemetry_LogOperation]([LogOperation] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

