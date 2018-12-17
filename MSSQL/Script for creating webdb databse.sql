use master
go

if exists(select * from sys.databases where name = 'webdb') begin
	drop database webdb
end
go

create database webdb
on (
    name= webdb,
    filename= 'c:\base\webdb.mdf',
    size= 25MB,
    maxsize= 50MB,
    filegrowth= 30%
)
log on (
    name= webdb_Log,
    filename= 'c:\base\webdb.ldf',
    size= 5MB,
    maxsize= 15MB,
    filegrowth= 30%
)
go

use webdb
go

create table Roles (
   id                   tinyint              identity,
   authority            varchar(45)          not null,
   cDate                datetime             not null default getdate(),
   constraint PK_ROLES primary key (id)
)

create table Users (
   id                   bigint               identity,
   name                 varchar(93)          not null,
   pass                 varchar(101)         not null,
   active               tinyint              not null,
   fkRole               tinyint              not null,
   cDate                datetime             not null default getdate(),
   constraint PK_USERS primary key (id)
)

alter table Users
   add constraint FK_Users_Ref_Roles foreign key (fkRole)
      references Roles (id)

create unique index UI_NAME on Users ( name ASC )
go

declare 
   @id_roles int;

insert into dbo.Roles(authority) values('ROLE_USER')
set @id_roles = @@IDENTITY

insert into dbo.Users(name, pass, active, fkRole) values('test@test.com', 'testcom', 1, @id_roles)
insert into dbo.Users(name, pass, active, fkRole) values('test@test.org', 'testorg', 1, @id_roles)
insert into dbo.Users(name, pass, active, fkRole) values('test@test.edu', 'testedu', 0, @id_roles)
go

create view vwUserWithRole
as
select u.id as uID, u.name, u.pass, u.active, u.cDate as uDate, r.id as rID, r.authority, r.cDate as rDate
from Users u
join Roles r on r.id = u.fkRole
go

select uID, name, pass, active, uDate, rID, authority, rDate from vwUserWithRole
go