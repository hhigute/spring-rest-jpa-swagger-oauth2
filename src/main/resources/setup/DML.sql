use Investment;
go


--password = password
INSERT INTO [dbo].[Users] ([Username] ,[Password] ,[Enabled],[CreatedTime]) VALUES ('user','pwd',1, getDate());
INSERT INTO [dbo].[Users] ([Username] ,[Password] ,[Enabled],[CreatedTime]) VALUES ('admin','pwd',1, getDate());

INSERT INTO [dbo].[Role] ([Id],[Name]) VALUES (1,'USER');
INSERT INTO [dbo].[Role] ([Id],[Name]) VALUES (2,'ADMIN');

INSERT INTO [dbo].[UsersRole] ([IdUser],[IdRole]) VALUES (1, 1);
INSERT INTO [dbo].[UsersRole] ([IdUser],[IdRole]) VALUES (2, 2);


INSERT INTO [dbo].[oauth_client_details]
           ([client_id]
           ,[resource_ids]
           ,[client_secret]
           ,[scope]
           ,[authorized_grant_types]
           ,[web_server_redirect_uri]
           ,[authorities]
           ,[access_token_validity]
           ,[refresh_token_validity]
           ,[additional_information]
           ,[autoapprove])
     VALUES
           ('test',
			'xpto_resource_id',
			'$2a$10$th819bV9jdD1kvBephgL8OVexNgF537vEIZmf3BbcaukwclntKz16', --value = secret
			'read,write',
			'password,authorization_code,refresh_token,implicit,client_credentials',
			NULL,
			'ADMIN',
			'180',
			'1800',
			NULL,
			NULL);
go


           





