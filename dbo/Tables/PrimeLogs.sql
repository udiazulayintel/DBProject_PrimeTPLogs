CREATE TABLE [dbo].[PrimeLogs] (
    [timestamp]             DATETIME      NOT NULL,
    [logLevel]              VARCHAR (15)  NOT NULL,
    [logType]               VARCHAR (50)  NOT NULL,
    [area]                  VARCHAR (150) NOT NULL,
    [operationName]         VARCHAR (100) NOT NULL,
    [startTime]             DATETIME      NULL,
    [duration]              FLOAT (53)    NULL,
    [testMethodName]        VARCHAR (250) NULL,
    [InitExecutionNumber]   SMALLINT      NULL,
    [globalLoggerSessionId] VARCHAR (50)  NULL,
    [parameters]            VARCHAR (MAX) NULL,
    [ActivityId]            VARCHAR (100) NULL,
    [ParentId]              VARCHAR (100) NULL,
    [instanceName]          VARCHAR (500) NULL,
    [dutId]                 INT           NULL,
    [ipId]                  INT           NULL,
    [VPO]                   VARCHAR (20)  NULL,
    [Operation]             VARCHAR (15)  NULL,
    [ipName]                VARCHAR (25)  NULL,
    [package]               VARCHAR (25)  NULL,
    [bomGroup]              VARCHAR (25)  NULL,
    [testFlow]              VARCHAR (25)  NULL,
    [programName]           VARCHAR (50)  NULL,
    [LotSessionId]          VARCHAR (50)  NULL,
    [DeviceSessionId]       VARCHAR (50)  NULL,
    [TestOrderNumber]       INT           NULL,
    [UnitId]                VARCHAR (50)  NULL,
    [AgentName]             VARCHAR (25)  NULL,
    [TesterName]            VARCHAR (50)  NOT NULL,
    [CellName]              VARCHAR (50)  NOT NULL,
    [uploadDatetimeUTC]     DATETIME      NOT NULL
);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_gs]
    ON [dbo].[PrimeLogs]([globalLoggerSessionId] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_init]
    ON [dbo].[PrimeLogs]([InitExecutionNumber] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_ParentId]
    ON [dbo].[PrimeLogs]([ParentId] ASC) WITH (FILLFACTOR = 80);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_test]
    ON [dbo].[PrimeLogs]([testMethodName] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_LogLevel]
    ON [dbo].[PrimeLogs]([logLevel] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_ActivityId]
    ON [dbo].[PrimeLogs]([ActivityId] ASC) WITH (FILLFACTOR = 80);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_UnitId]
    ON [dbo].[PrimeLogs]([UnitId] ASC) WITH (FILLFACTOR = 80);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_VPO]
    ON [dbo].[PrimeLogs]([VPO] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_Dev_logType]
    ON [dbo].[PrimeLogs]([logType] ASC);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_area]
    ON [dbo].[PrimeLogs]([area] ASC) WITH (FILLFACTOR = 80);


GO

CREATE NONCLUSTERED INDEX [IX_PrimeLogs_operationName]
    ON [dbo].[PrimeLogs]([operationName] ASC) WITH (FILLFACTOR = 80);


GO

