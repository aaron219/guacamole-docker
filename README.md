# Deploy Guacamole with SSL in Docker and docker-compose (ext with TOTP)

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

> (option) Allow docker command without sudo

```
usermod -aG docker [username]
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

- `Method 1` : Deploy without env file

```
docker-compose -f guacamole.yml up -d
```

- `Method 2` : Deploy with env file

```
docker-compose -f guacamole-with-env.yml up -d
```

4. Open browser and launch Guacamole

> Default username: `guacadmin`  
> Default password: `guacadmin`

```
https://[host_ip]:5443
```

## Deploy extensions (Option)

### Enable TOTP and custom login page

> comment out the `volumes` (in `guacamole` services)

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

## Remove containers and its data

1. Stop containers

```
docker-compose -f guacamole.yml down
```

2. Remove data

```
sudo rm -rf guacamole-data
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
> deploy with ssl in nginx

- guacamole-with-env.yml

> docker-compose file  
> deploy with ssl in nginx and using env file

- nginx-default-file

> nginx default configure file

- perpare.sh

> perpare script  
> create working directory and copy requried file to working directory

## Setup Connection

- For Windows 10 / Windows Server 2016

> Set Authentifizierung -> Sicherheitsmodus to "NLA"  
> Set Authentifizierung -> Serverzertifikat ignorieren with "Check"

- For Linux (if openSSH ver. over 7.8)

> Add the following in the end of ssh_config(/etc/ssh/ssh_config)

```
HostKeyAlgorithms +ssh-rsa
```

## Details

### Container Current Version

> guacd -> 1.4.0  
> guacamole -> 1.4.0  
> mariadb -> 10.8.3  
> nginx -> 1.23.1

> To be continue...

---

## Update History

> 2022/08/09
> 
>> Modify nginx configure file
>
> 2022/08/08
> 
>> Add nginx-default file
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