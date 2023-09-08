CREATE TABLE [dbo].[PrimeTelemetry_TestMethodName] (
    [TestMethodNameId] INT           IDENTITY (1, 1) NOT NULL,
    [PartitionId]      TINYINT       NOT NULL,
    [TestMethodName]   VARCHAR (250) NOT NULL,
    CONSTRAINT [PrimeTelemetry_TestMethodName_PK] PRIMARY KEY CLUSTERED ([TestMethodNameId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_TestMethodName_UI]
    ON [dbo].[PrimeTelemetry_TestMethodName]([TestMethodName] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

