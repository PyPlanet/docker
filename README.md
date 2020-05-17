# How to use [pyplanet/controller image](https://hub.docker.com/r/pyplanet/controller/)

`docker run -d --name MySuperPyplanetController -e ... (available env variables below) pyplanet/controller`

## Environment Variables

------

### If you are using MySQL (or MariaDB, PerconaDB, etc).

`MYSQL_DATABASE` ( default : pyplanet ) 

`MYSQL_HOST` 

`MYSQL_USER` ( default : pyplanet )

`MYSQL_PASSWORD` ( default : pyplanet )

### If you are using PostgreSQL.

`POSTGRES_DB` ( default : pyplanet )

`POSTGRES_HOST`

`POSTGRES_USER` ( default : pyplanet )

`POSTGRES_PASSWORD` ( default : pyplanet )



`MANIAPLANET_HOST` ( default : dedicated )

Address of the maniaplanet server. 

`MANIAPLANET_PORT` ( default : 5000 )

XML-RPC port.

`MANIAPLANET_USER` ( default : SuperAdmin )

`MANIAPLANET_PASSWORD` ( default: SuperAdmin )

`MANIAPLANET_OWNER_LOGIN`

The owner will get *ALL* the permissions in the system.

# Docker Compose and PyPlanet

This repository contain a docker-compose template that you can easily use and adapt according to your needs.
More templates will come in a near futur.

### Full template

This template provide a full setup, including Maniaplanet, PyPlanet, PHPMyAdmin, MariaDB and SFTP server.
Here is a litle schematic to describe the network : 
```          
           +--------+
           |NETWORKS|
           +--------+

Back Network        Front Network
     +                    +
     |                    |
     |                    |
     |    +--------+      |
     |----|PyPlanet|      |
     |    +--------+      |
     |                    |
     |    +-------+       |
 3306|----|MariaDB|       |
     |    +-------+       |
     |                    |
     |    +-----------+   |
 5000|----|Maniaplanet|---|2350,3450
     |    +-----------+   |
     |                    |
     |    +----------+    |
     +----|PHPMyAdmin|----|8080
          +----------+    |
                          |
                +----+    |
                |SFTP|----+8022
                +----+    
  
```
This template use 4 named volumes :
* **maniaplanet** : Maniaplanet server folder.
* **maniaplanet_configs** : Config that is used at the first start of the Maniaplanet container.
* **pyplanet** : PyPlanet folder.
* **database** : /var/lib/mysql of mariadb container.

To use this template you only have two things to do :
* Rename dedicated_vars.env.default to dedicated_vars.env and fill it.
* Generate your ssh host key by executing the ssh_host_keygen.sh script.

Then you are ready to use it ``docker-compose up -d``.

### How to update ?

To update, you just need to execute `docker-compose pull` then `docker-compose up -d`.
