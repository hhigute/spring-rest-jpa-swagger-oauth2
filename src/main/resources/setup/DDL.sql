create database Investment;
go

use Investment;
go

-- More tables --> https://github.com/spring-projects/spring-security-oauth/blob/master/spring-security-oauth2/src/test/resources/schema.sql

-- table Users and Role used to authorization 
create table dbo.Users (
	Id int not null IDENTITY(1,1) primary key,
	Username nvarchar(100) not null, 
	Password nvarchar(500) not null,
	Enabled bit not null,
	CreatedTime datetime,
	UpdatedTime datetime
);
alter table Users add constraint UQ_Users unique (Username);

create table dbo.Role(
	Id int not null primary key,
	Name nvarchar(50) not null
);
alter table Role add constraint UQ_Role unique (Name); 


create table dbo.UsersRole (
	IdUser int not null,
	IdRole int not null
);
alter table UsersRole add constraint PK_UsersRole primary key (IdUser,IdRole);
alter table UsersRole add constraint FK_UsersRole_User foreign key (IdUser) references Users(Id);
alter table UsersRole add constraint FK_UsersRole_Role foreign key (IdRole) references Role(Id);


-- table to save access toke
create table oauth_access_token (
  token_id VARCHAR(255),
  token varbinary(max),
  authentication_id VARCHAR(255) PRIMARY KEY,
  user_name VARCHAR(255),
  client_id VARCHAR(255),
  authentication varbinary(max),
  refresh_token VARCHAR(255)
);

-- table to save access toke
create table oauth_refresh_token (
  token_id VARCHAR(255),
  token varbinary(max),
  authentication varbinary(max)
);

-- table used to authentication flow "implicit"
create table oauth_client_details (
  client_id VARCHAR(256) PRIMARY KEY,
  resource_ids VARCHAR(256),
  client_secret VARCHAR(256),
  scope VARCHAR(256),
  authorized_grant_types VARCHAR(256),
  web_server_redirect_uri VARCHAR(256),
  authorities VARCHAR(256),
  access_token_validity INTEGER,
  refresh_token_validity INTEGER,
  additional_information VARCHAR(4096),
  autoapprove VARCHAR(256)
);