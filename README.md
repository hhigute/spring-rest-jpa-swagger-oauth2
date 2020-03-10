# Spring + JPA + Swagger + OAuth2

This example used JPA, Swagger and Security/OAuth2 (OAuth  __implicit flow__ )

I used [Spring Boot](https://start.spring.io) to create the base project.

_Dependencies:_

* Spring Web
* Spring Data JPA

Bellow others Maven dependencies that I configured manually.

		<!-- JPA + MS-SQLServer -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
		</dependency>
		<dependency>
			<groupId>com.microsoft.sqlserver</groupId>
			<artifactId>mssql-jdbc</artifactId>
			<version>8.2.0.jre8</version>
		</dependency>

		<!-- Security + OAuth -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-security</artifactId>
		</dependency>
		<dependency>
			<groupId>org.springframework.security.oauth</groupId>
			<artifactId>spring-security-oauth2</artifactId>
			<version>2.2.5.RELEASE</version>
		</dependency>
		
		<!-- Swagger -->
		<dependency>
			<groupId>io.springfox</groupId>
			<artifactId>springfox-swagger2</artifactId>
			<version>2.9.2</version>
		</dependency>
		<dependency>
			<groupId>io.springfox</groupId>
			<artifactId>springfox-swagger-ui</artifactId>
			<version>2.8.0</version>
		</dependency>
		<dependency>
			<groupId>io.springfox</groupId>
			<artifactId>springfox-bean-validators</artifactId>
			<version>2.8.0</version>
		</dependency>


### _Setup / Pre-Requirements_

We need to create the tables bellow to authenticate the user and store access tokens. 


![Alt text](./doc/DatabaseDiagram.png?raw=true "Database diagram")



* __oauth_access_token__
     - _This table store the access token used during the "authentication" flow._
   

* __users__
     - _This table store the user informations that request "authorization"._

   
* __role__
     - _This table store the roles that users can have._

   
* __usersRole__
     - _This table associates users and roles._
   

* __oauth_refresh_token__
     - _This table store the refresh token._
   
   
* __oauth_client_details__
     - _This table store the user informations that want to authenticate_

   

To create the tables/structure previous described, you have to follow the steps bellow.


* MS SQL Server 2017 Express Edition

>Run the files/scripts .sql found in the folder "src/main/resources/setup"


``` 
1) DDL.sql
2) DML.sql
```

* If you don't have or don't want to install SQLServer, you can follow the steps bellow to create your database in `Docker` container.



1. **Start Docker** 
   
   In my case I used Docker Desktop for windows
   
2. **Create MS SQL Server container**

   Run the command bellow in Prompt Ms-DOS </br>
   PS: Password must be strong </br></br> 
   `docker run -d -p 1433:1433 -e sa_password=<<SET_YOUR_PASSWORD>> -e ACCEPT_EULA=Y --name SqlServerContainer microsoft/mssql-server-windows-express`
   
   ![Alt text](./doc/dockerrun.png?raw=true "docker SqlServerContainer")	

3. **Check Installation**
	
   `docker ps -a`
   
   ![Alt text](./doc/dockerps-a.png?raw=true "docker ps -a")	
	
4. **Connect to SqlServerContainer**	
	
   `sqlcmd -S localhost,1433 -U SA -P <<SET_YOUR_PASSWORD>>`
   
   ![Alt text](./doc/sqlcmd.png?raw=true "sqlcmd connect SqlServerContainer")

5. **Check Connection**
		
   `select @@version`
   	
   ![Alt text](./doc/sqlcmd_check.png?raw=true "check SqlServerContainer")
	
6. **Create tables to run our project**

   `Run the files/scripts .sql found in the folder "src/main/resources/setup"`
	
   `sqlcmd -S localhost,1433 -U SA -P <<SET_YOUR_PASSWORD>> -i <PATH>\DDL.sql -o <PATH>\output_DDL.txt`
	
   `sqlcmd -S localhost,1433 -U SA -P <<SET_YOUR_PASSWORD>> -i <PATH>\DML.sql -o <PATH>\output_DML.txt`
	![Alt text](./doc/sqlcmd_tables.png?raw=true "check SqlServerContainer")


### _Update file application.properties_


		###### Server ######
		server.port=8083
		host=http://localhost:8083
		###### Datasource ######
		spring.datasource.driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
		spring.datasource.url=jdbc:sqlserver://localhost;databaseName=Investment
		spring.datasource.username=<<SET_YOUR_USERNAME>>
		spring.datasource.password=<<SET_YOUR_PASSWORD>>
		################### JPA Configuration ##########################
		spring.jpa.show-sql=true
		spring.jpa.properties.hibernate.format_sql = true
		spring.jpa.hibernate.dialect=org.hibernate.dialect.SQLServer2012Dialect
		spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl


### _Install maven dependencies_ 

	mvn clean install
   ![Alt text](./doc/mvn_cleaninstall.png?raw=true "mvn clean install")


### _Build and start the application_

   Access swagger interface and test 
	
   `http://localhost:8083/swagger-ui.html`

   ![Alt text](./doc/swagger.png?raw=true "Swagger")

   `client_id -> The value inserted into table "oauth_client_details" (DML.sql)`
	
   ![Alt text](./doc/swagger_authentication.png?raw=true "Swagger")
   
   `User and Password -> The value inserted into table "users" (DML.sql)`

   ![Alt text](./doc/swagger_authorization.png?raw=true "Swagger")   
   
   ![Alt text](./doc/swagger_authorization_oauth_approval.png?raw=true "Swagger")
   
   ![Alt text](./doc/swagger_authorization_approved.png?raw=true "Swagger")
   
   ![Alt text](./doc/swagger_authorization_approved_execution.png?raw=true "Swagger")
   
   