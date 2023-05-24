# Simple Docker

## Part 1. Готовый докер

**== Task ==**

##### Взять официальный докер образ с nginx и выкачать его при помощи `docker pull`.
![part1.1](img/part1-1.png)


##### Проверить наличие докер образа через docker images
![part1.2](img/part1-2.png)


##### Запустить докер образ через docker run -d [image_id|repository]
##### Проверить, что образ запустился через docker ps
![part1.3](img/part1-3.png)

##### Посмотреть информацию о контейнере через docker inspect [container_id|container_name]
##### По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера
![part1.4](img/part1-4.png)
![part1.4](img/part1-5.png)

> Checking container with the image is running

##### View container information with `docker inspect [container_id|container_name]`

![part1.5](img/1.5.png)

> Full inspect report about container

##### From the command output define and write in the report the container size, list of mapped ports and container ip

- Size: 67108864 = 64 Mb;
- Mapped ports: none;
- Container IP: 172.17.0.2

##### Stop docker image with `docker stop [container_id|container_name]`

![part1.6](img/1.6.png)

> Stoping the container

##### Check that the image has stopped with `docker ps`

![part1.7](img/1.7.png)

> Checking if there is no running containers

##### Run docker with mapped ports 80 and 443 on the local machine with *run* command

![part1.8](img/1.8.png)

> Starting image with mapped ports and check the result by PS

##### Check that the **nginx** start page is available in the browser at *localhost:80*

![part1.9](img/1.9.png)

> Nginx start page is available from local machine browser

##### Restart docker container with `docker restart [container_id|container_name]`, Check in any way that the container is running

![part1.10](img/1.10.png)

> Restarting container and check it is running by PS

## Part 2. Operations with container

**== Task ==**

##### Read the *nginx.conf* configuration file inside the docker container with the *exec* command

![part2.1](img/2.1.png)

> Reading nginx conf file using cat through exec

##### Create a *nginx.conf* file on a local machine

![part2.2](img/2.2.png)

> Pipeing output of previous step to nginx.conf file on local machine

##### Configure it on the */status* path to return the **nginx** server status page

![part2.3](img/2.3.png)

> Adding location property to nginx.conf file on local machine

##### Copy the created *nginx.conf* file inside the docker image using the `docker cp` command

![part2.4](img/2.4.png)

> Copying the conf file from local machine to container using CP

##### Restart **nginx** inside the docker image with *exec*

![part2.5](img/2.5.png)

> Restarting nginx server in container through EXEC

##### Check that *localhost:80/status* returns the **nginx** server status page

![part2.6](img/2.6.png)

> Checking return message of new page by CURL

##### Export the container to a *container.tar* file with the *export* command

![part2.7](img/2.7.png)

> Exporting container and check its existance by ls

##### Stop the container

![part2.8](img/2.8.png)

> Stopping container and check it with PS

##### Delete the image with `docker rmi [image_id|repository]`without removing the container first

![part2.9](img/2.9.png)

> Deleting nginx image with force (-f) flag

##### Delete stopped container

![part2.10](img/2.10.png)

> Deleting container that was previously exported

##### Import the container back using the *import* command

![part2.11](img/2.11.png)

> Importing the container image with IMPORT

##### Run the imported container, Check that *localhost:80/status* returns the **nginx** server status page

![part2.12](img/2.12.png)

> Starting the imported container with mapped ports and in backgroun (-d), command NGINX is necessary to start web server

- Add the following screenshots to the report:
    - the call and output of all commands used in this part of the task;
    - the contents of the created *nginx.conf* file;
    - the **nginx** server status page at *localhost:80/status*.


## Part 3. Mini web server

It's time to take a little break from the docker to prepare for the last stage. It's time to write your own server.

**== Task ==**

##### Write a mini server in **C** and **FastCgi** that will return a simple page saying `Hello World!`

- docker pull nginx
> Pulling image for nginx container
- docker run -d -p 81:81 nginx
> Running container with mapped 81 port
- docker exec 045f9b1a8218 apt update
> Updating APT to install packages
- docker exec 045f9b1a8218 apt install gcc libfcgi-dev spawn-fcgi -y
> Installing necessary packages: gcc - compiling source C code, libfcgi-dev - FastCGI library, spawn-fcgi - FastCGI daemon tool
- docker exec 045f9b1a8218 mkdir /etc/nginx/mini_server
> Creating directory for source code
- docker cp mini-server.c 045f9b1a8218:/etc/nginx/mini_server/
> Copying source code to container
- docker cp nginx.conf 045f9b1a8218:/etc/nginx/
> Copying nginx configuration file proxying 81 port to 8080 to container
- docker exec 045f9b1a8218 gcc /etc/nginx/mini_server/mini-server.c -o /etc/nginx/mini_server/mini-server.fcgi -lfcgi
> Compiling fastcgi server
- docker exec 045f9b1a8218 spawn-fcgi -p 8080 /etc/nginx/mini_server/mini-server.fcgi
> Starting FastCGI server on 8080 port

##### Run the written mini server via *spawn-fcgi* on port 8080

![part3.1](img/3.1.png)

> Source code of mini server

##### Write your own *nginx.conf* that will proxy all requests from port 81 to *127.0.0.1:8080*

![part3.2](img/3.2.png)

> Listening 81 port from 8080 in nginx configuration file

##### Check that browser on *localhost:81* returns the page you wrote

![part3.3](img/3.3.png)

> Checking output on localhost:81

##### Put the *nginx.conf* file under *./nginx/nginx.conf* (you will need this later)

## Part 4. Your own docker

**== Task ==**

#### Write your own docker image that:
##### 1) builds mini server sources on FastCgi from [Part 3](#part-3-mini- web-server)
##### 2) runs it on port 8080
##### 3) copies inside the image written *./nginx/nginx.conf*
##### 4) runs **nginx**.
_**nginx** can be installed inside the docker itself, or you can use a ready-made image with **nginx** as base._
##### Build the written docker image with `docker build`, specifying the name and tag

- docker build . -t server-build:latest
> Building image from dockerfile in src with "server-build" name and "latest" tag

##### Check with `docker images` that everything is built correctly

![part4.1](img/4.1.png)

> Building an image and checking it

##### Run the built docker image by mapping port 81 to 80 on the local machine and mapping the *./nginx* folder inside the container to the address where the **nginx** configuration files are located (see [Part 2](#part-2-operations-with-container))

- docker run -d -p 80:81 -v "$(PWD)"/nginx/:/etc/nginx/ server-build
> Running container in background (-d) with mapped port from host's 80 to container's 81 (-v), mapped folder (-v)

##### Check that the page of the written mini server is available on localhost:80

- curl localhost:80
> Checking main page of FastCGI server

##### Add proxying of */status* page in *./nginx/nginx.conf* to return the **nginx** server status

![part4.2](img/4.2.png)

> Editing nginx configuration file to see the result of mounting folders

##### Restart docker image
*If everything is done correctly, after saving the file and restarting the container, the configuration file inside the docker image should update itself without any extra steps

- docker restart 41562b1f6a1a
> Restarting container to refresh nginx configuration file

##### Check that *localhost:80/status* now returns a page with **nginx** status

- curl localhost:80/status
> Checking if everything is up to date

## Part 5. **Dockle**

Once you've written the image, it's never a bad idea to check it for security.

**== Task ==**

##### Check the image from the previous task with `dockle [image_id|repository]`

- brew install goodwithtech/r/dockle
> Installing Dockle on MacOS from github repository

![part5.1](img/5.1.png)

> List of errors and warnings

##### Fix the image so that there are no errors or warnings when checking with **dockle**

- First fatal error is solved by adding ```-ak NGINX_GPGKEY```;
- Second fatal error means that there is unnecessary caches on container, this is solved by adding additional instruction to clear caches;
- Add line USER nginx at the end of dockerfile to fix the first warning;
- The warning with tag can be fixed by rebuilding container with other than "latest" tag;

![part5.2](img/5.2.png)

> Result of fixing errors and warnings in dockle

- First INFO can be fixed by:
> export DOCKER_CONTENT_TRUST=1
- Second INFO asks user to implement HEALTHCHECK instruction in Dockerfile to test availability of the server every 5 seconds for example;
> HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl --fail localhost || exit 1
- To fix third INFO it is needed to grant necessary rights to the list of files and folders.

![part5.3](img/5.3.png)

> Result of fixing INFOs

![part5.4](img/5.4.png)

> Final version of Dockerfile

## Part 6. Basic **Docker Compose**

**== Task ==**

##### Write a *docker-compose.yml* file, using which:
##### 1) Start the docker container from [Part 5](#part-5-dockle) _(it must work on local network, i.e., you don't need to use **EXPOSE** instruction and map ports to local machine)_

![part6.1](img/6.1.png)

> Building container from part 5 Dockerfile without mapping ports
##### 2) Start the docker container with **nginx** which will proxy all requests from port 8080 to port 81 of the first container

![part6.2](img/6.2.png)

> Nginx configuration file that makes server listen port 8080 and send requests to 81 port of first container

##### Map port 8080 of the second container to port 80 of the local machine

![part6.3](img/6.3.png)

> Nginx container with mapped 8080 port to localhost port 80 and mapped nginx configuration file with proxying requests from second container port 8080 to first container with mini server port 81

##### Stop all running containers. Build and run the project with the `docker-compose build` and `docker-compose up` commands

![part6.4](img/6.4.png)

> Checking absence of running containers, building and running two containers with `docker-compose` command

##### Check that the browser returns the page you wrote on *localhost:80* as before

![part6.5](img/6.5.png)

> Checking two running containers and availability of web page at port 80
