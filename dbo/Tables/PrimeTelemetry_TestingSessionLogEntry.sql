CREATE TABLE [dbo].[PrimeTelemetry_TestingSessionLogEntry] (
    [LogEntryId]            BIGINT        NOT NULL,
    [PartitionId]           TINYINT       NOT NULL,
    [LotInTestingSessionId] INT           NULL,
    [LoggingSessionId]      INT           NOT NULL,
    [LogLevelId]            INT           NOT NULL,
    [LogTypeId]             INT           NOT NULL,
    [AreaId]                INT           NOT NULL,
    [ActivityId]            VARCHAR (200) NULL,
    [ParentId]              VARCHAR (200) NULL,
    [StartTime]             DATETIME      NULL,
    [DurationInMillisecond] FLOAT (53)    NULL,
    [InstanceNameId]        INT           NULL,
    [TestMethodNameId]      INT           NULL,
    [UltOrVisualId]         VARCHAR (50)  NULL,
    [DutId]                 INT           NULL,
    [IpId]                  INT           NULL,
    [IpName]                VARCHAR (25)  NULL,
    [WithinSessionDutId]    INT           NULL,
    [TestOrderNumber]       INT           NULL,
    [LogOperationId]        INT           NULL,
    CONSTRAINT [PrimeTelemetry_TestingSessionLogEntry_PK] PRIMARY KEY CLUSTERED ([LogEntryId] ASC, [PartitionId] ASC) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId])
) ON [PrimeTelemetry_PartitionNumber_PS] ([PartitionId]);


GO

