CREATE TABLE [dbo].[PrimeTelemetry_Area] (
    [AreaId]      INT           IDENTITY (1, 1) NOT NULL,
    [PartitionId] TINYINT       NOT NULL,
    [Area]        VARCHAR (150) NOT NULL,
    CONSTRAINT [PrimeTelemetry_Area_PK] PRIMARY KEY CLUSTERED ([AreaId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_Area_UI]
    ON [dbo].[PrimeTelemetry_Area]([Area] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

