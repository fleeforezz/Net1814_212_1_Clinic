USE [K18212Clinic]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Total] [money] NOT NULL,
	[PaymentMethod] [varchar](50) NOT NULL,
	[PaymentStatus] [bit] NOT NULL,
	[DentistName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Appointment] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentDetail]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentDetail](
	[AppointmentDetailID] [int] NOT NULL,
	[AppointmentID] [int] NOT NULL,
	[ServiceID] [int] NOT NULL,
	[IsPeriodic] [bit] NOT NULL,
	[Day] [int] NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
 CONSTRAINT [PK_AppointmentServices] PRIMARY KEY CLUSTERED 
(
	[AppointmentDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clinic]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clinic](
	[ClinicID] [int] NOT NULL,
	[OwnerName] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Contact] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[ClinicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Record]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Record](
	[RecordID] [int] NOT NULL,
	[ClinicID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[NumOfVisits] [int] NOT NULL,
 CONSTRAINT [PK_Record] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordDetail]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordDetail](
	[RecordDetailID] [int] NOT NULL,
	[AppointmentDetailID] [int] NOT NULL,
	[RecordID] [int] NOT NULL,
	[Evaluation] [text] NOT NULL,
	[Reccommend] [text] NOT NULL,
 CONSTRAINT [PK_RecordDetail] PRIMARY KEY CLUSTERED 
(
	[RecordDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 5/16/2024 7:33:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ServiceID] [int] NOT NULL,
	[ClinicID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Price] [money] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Service] PRIMARY KEY CLUSTERED 
(
	[ServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD  CONSTRAINT [App_Cus] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Appointment] CHECK CONSTRAINT [App_Cus]
GO
ALTER TABLE [dbo].[AppointmentDetail]  WITH CHECK ADD  CONSTRAINT [AppS_App] FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[AppointmentDetail] CHECK CONSTRAINT [AppS_App]
GO
ALTER TABLE [dbo].[AppointmentDetail]  WITH CHECK ADD  CONSTRAINT [AppS_Ser] FOREIGN KEY([ServiceID])
REFERENCES [dbo].[Service] ([ServiceID])
GO
ALTER TABLE [dbo].[AppointmentDetail] CHECK CONSTRAINT [AppS_Ser]
GO
ALTER TABLE [dbo].[Record]  WITH CHECK ADD  CONSTRAINT [Rec_Cli] FOREIGN KEY([ClinicID])
REFERENCES [dbo].[Clinic] ([ClinicID])
GO
ALTER TABLE [dbo].[Record] CHECK CONSTRAINT [Rec_Cli]
GO
ALTER TABLE [dbo].[Record]  WITH CHECK ADD  CONSTRAINT [Rec_Cus] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Record] CHECK CONSTRAINT [Rec_Cus]
GO
ALTER TABLE [dbo].[RecordDetail]  WITH CHECK ADD  CONSTRAINT [RecD_AppD] FOREIGN KEY([AppointmentDetailID])
REFERENCES [dbo].[AppointmentDetail] ([AppointmentDetailID])
GO
ALTER TABLE [dbo].[RecordDetail] CHECK CONSTRAINT [RecD_AppD]
GO
ALTER TABLE [dbo].[RecordDetail]  WITH CHECK ADD  CONSTRAINT [RecD_Rec] FOREIGN KEY([RecordID])
REFERENCES [dbo].[Record] ([RecordID])
GO
ALTER TABLE [dbo].[RecordDetail] CHECK CONSTRAINT [RecD_Rec]
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD  CONSTRAINT [Ser_Com] FOREIGN KEY([ClinicID])
REFERENCES [dbo].[Clinic] ([ClinicID])
GO
ALTER TABLE [dbo].[Service] CHECK CONSTRAINT [Ser_Com]
GO
