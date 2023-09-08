CREATE TABLE [dbo].[PrimeTelemetry_TestingSessionLogEntry_Parameters] (
    [LogEntryId]  BIGINT        NOT NULL,
    [PartitionId] TINYINT       NOT NULL,
    [Parameters]  VARCHAR (MAX) NULL,
    CONSTRAINT [PrimeTelemetry_TestingSessionLogEntry_Parameters_PK] PRIMARY KEY CLUSTERED ([LogEntryId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

