CREATE TABLE [dbo].[PrimeTelemetry_DutId] (
    [SessionDutId] INT              IDENTITY (1, 1) NOT NULL,
    [PartitionId]  TINYINT          NOT NULL,
    [LoggerDutId]  UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PrimeTelemetry_DutId_PK] PRIMARY KEY CLUSTERED ([SessionDutId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_DutId_UI]
    ON [dbo].[PrimeTelemetry_DutId]([LoggerDutId] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

