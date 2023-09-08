CREATE TABLE [dbo].[APIConfig_old] (
    [Site]           VARCHAR (10)    NOT NULL,
    [Config]         NVARCHAR (2000) NOT NULL,
    [IsEnabled]      BIT             NOT NULL,
    [ConsumerConfig] NVARCHAR (2000) NULL,
    CONSTRAINT [PK_APIConfig] PRIMARY KEY CLUSTERED ([Site] ASC)
);


GO

