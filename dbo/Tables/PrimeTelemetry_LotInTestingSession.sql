CREATE TABLE [dbo].[PrimeTelemetry_LotInTestingSession] (
    [LotInTestingSessionId] INT              IDENTITY (1, 1) NOT NULL,
    [PartitionId]           TINYINT          NOT NULL,
    [LoggerLotInSessionId]  UNIQUEIDENTIFIER NOT NULL,
    [LoggerSessionId]       UNIQUEIDENTIFIER NOT NULL,
    [Lot]                   VARCHAR (20)     NOT NULL,
    [Operation]             VARCHAR (15)     NULL,
    [Facility]              VARCHAR (15)     NULL,
    [Package]               VARCHAR (25)     NULL,
    [BomGroup]              VARCHAR (25)     NULL,
    [ProcessStep]           VARCHAR (25)     NULL,
    [InitExecutionNumber]   SMALLINT         NULL,
    CONSTRAINT [PrimeTelemetry_LotInTestingSession_PK] PRIMARY KEY CLUSTERED ([LotInTestingSessionId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE NONCLUSTERED INDEX [PrimeTelemetry_LotInTestingSession_Lot_Operation_ProcessStep]
    ON [dbo].[PrimeTelemetry_LotInTestingSession]([Lot] ASC, [Operation] ASC, [ProcessStep] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE UNIQUE NONCLUSTERED INDEX [PrimeTelemetry_LotInTestingSession_LoggerLotInSessionId_UI]
    ON [dbo].[PrimeTelemetry_LotInTestingSession]([LoggerLotInSessionId] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

CREATE NONCLUSTERED INDEX [PrimeTelemetry_LotInTestingSession_LoggerSessionId]
    ON [dbo].[PrimeTelemetry_LotInTestingSession]([LoggerSessionId] ASC, [PartitionId] ASC)
    ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

