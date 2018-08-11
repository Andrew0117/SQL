use database
go

-- version < 2016
--if OBJECT_ID('dbo.UpdateTable', 'U') is not null
--   drop table UpdateTable
--go

-- version >= 2016
--drop table if exist dbo.UpdateTable
--go

CREATE TABLE UpdateTable(
	Id int IDENTITY NOT NULL,
	CheckDateID int not null,
	SSN varchar (10),
	CheckDate datetime,
	price money,
	CONSTRAINT PK_UpdateTable PRIMARY KEY (CheckDateID ASC, Id ASC)
)
go

Declare @CMax int,
		@PortionS int,
		@PortionE int

set @PortionS = 1
set @PortionE = 350000
select @CMax = count(CheckDateID) from UpdateTable

While @PortionS != @PortionE +1 Begin
Update u
set price = price * 10
from (
	  SELECT table_id.price
	  from (  select t.price, ROW_NUMBER() OVER ( order by t.CheckDateID asc, t.Id asc) as row 
		      FROM UpdateTable t
		   ) as table_id 
	  where table_id.row >= @PortionS AND table_id.row <= @PortionE
	) u

set @PortionS = @PortionE +1
set @PortionE = Case 
					When (@PortionE + 350000) < @CMax Then @PortionE + 350000 
					Else @CMax 
				End
end
go