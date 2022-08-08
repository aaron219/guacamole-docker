# Deploy Guacamole with SSL in Docker and docker-compose (ext with TOTP)

---

## Update

> 2022/08/08
> 
>> Update Readme
> 
> 2022/08/07
>
>> Modify env file
>
> 2022/08/05
> 
>> First version
>

---

## Prerequistes

> Before deploy apache guacamole with docker, need to install the following

```
openssl
git
docker-ce
docker-ce-cli
docker-compose-plugin
```

---

## Deploy

> Clone form GIT reposityory and deploy

1. Clone form GIT

```
git clone "https://github.com/aaron219/guacamole-docker.git"
```

2. Run a prepare script

```
./prepare.sh
```

3. Start Guacamole

```
docker-compose -f guacamole.yml up -d
```

4. Open browser and launch Guacamole

> Default username: `guacadmin`  
> Default password: `guacadmin`

```
https://[host_ip]:5443
```

## Deploy option

1. Enable TOTP and custom login page

> Uncomment out the following

```
...
 guacamole:
  image: guacamole/guacamole
  container_name: guacamole
  restart: always
  depends_on:
   - guacd
   - mariadb
###Enable for use extensions and custom guacamole configure
#  volumes:
#   - ./guacamole-data/extensions/:/opt/guacamole/extensions
#   - ./guacamole-data/guacamole.properties:/opt/guacamole/guacamole.properties
  environment:
...
```

2. Use env file in yml

> Using the following command to replace step 3

```
docker-compose -f guacamole-with-env.yml up -d
```

## Description

- guacamole-docker-env

> docker-compose env file  
> 
>> - database's root and password  
>> - username and password which is connect between guacamole and database

- guacamole-pre-file

> extensions configure file and source file  
> 
>> - TOTP  
>> - custom login page  
>
> more plugin and how to configure -> https://guacamole.apache.org/releases/

- guacamole.yml

> docker-compose file  
> with ssl in nginx

- guacamole-with-env.yml

> docker-compose file  
> with ssl in nginx  
> with env file

- nginx-default-file

> nginx default configure file

- perpare.sh

> perpare script  
> create working directory and copy requried file to working directory

## Details

> To be continue...
