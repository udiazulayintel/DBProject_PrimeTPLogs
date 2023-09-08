CREATE TABLE [dbo].[PrimeTelemetry_InstanceName] (
    [InstanceNameId] INT           IDENTITY (1, 1) NOT NULL,
    [PartitionId]    TINYINT       NOT NULL,
    [InstanceName]   VARCHAR (500) NOT NULL,
    CONSTRAINT [PrimeTelemetry_InstanceName_PK] PRIMARY KEY CLUSTERED ([InstanceNameId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_InstanceName_UI]
    ON [dbo].[PrimeTelemetry_InstanceName]([InstanceName] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

