#from 
https://www.katacoda.com/learn?q=&hPP=12&idx=scenarios&p=0&is_v=1

install docker

#new convention use container managment etc before the actual command
#for more of the keywords type docker in the terminal
#basic commands
    docker run | container run -d | -it -p <port on machine : port on container> --name <container name|alias name> <repo|image name>:<version> #runs a container 
    #-p (publish)is used when a web app needs to be opened in the browser
    #-d(detached) starts container in detached mode use docker attach <image name> to use containers terminal
    #-it (interactive) starts a container in the foreground and starts and interactive shell terminal
    docker run | container run -it <image name> <command to run after container is created> 
    
    docker start | container start <name/id> #starts a container which is not running
                           #used to restart a container whose image is already created (ie after docker run is executed)
    docker stop | container stop<name/id> #shut down
    docker ps -a #-a to list stoped containers too
    docker container ls #same as docker ps
    docker images #all the images being used
    docker rm | conainer rm <name/id> #removes the image. does not remove a runnig container
    docker rm | conainer rm <name|id> -f #remove contaner even if it is running
    docker top <continer name> #lists the running process in an container 
    docker stats 
    docker container inspect <container name> 

#finding size of docker image
    docker images 
    docker images | grep <image name>
#to set env variables
    docker run | container run -d | -it -p <port:no> --name <container name|alias name> <repo|image name>:<version> --env | -e 

#starting a container which is stopped
    docker container start -ai <container name>
        #-ai for interactive mode use if docker container was created with -it flag
    docker container start <container name>
        #starts container in detatched mode

#executing a command in the container bash immedialty after the container is created
    docker container run -it --name <conatiner name> <image name> <terminal command>
    #if u want to access bash
        <terminal command> = bash
    #if using alpine instead of ubuntu
        <terminal command> = sh 
    

#<----bashing into container---->
#it can also be used to use bash with the a detached container
    docker exec -it <container name|alias>

#<------connecting to container----->
#copy ip address
#in etc/hosts(open with vim) folder create ssh key
#in the folder--->
    <ip address> <docker machine name>
    #click enter
    ssh root@<docker machine name>

    docker login

#when running a web app
    #in browser
        <docker machine name>:<port>

#<-----creating a docker image------>
    #create the needed config file if any such as nginx webpack etc

    FROM <IMAGE NAME>
    COPY <folder|file location in dev machine> <location in the docker container>    
    RUN <terminal commands> #to create a file/folder 
    ADD  #add/change file to existing folder or directories no terminal commands 
        #eg to change file ./nginx.conf() <space> /etc/nginx/conf.d/default.conf -> changes default.cong with nginx.conf

    EXPOSE <port number>

#<-----building docker image---->

#build:for images
     # run all the commands in the .dockerfile 
     #helps in initializiin ghto run the containers

#run: for conatiners (running instances of the images)
     #to acctually run the conainer for its working

#in the previously opened terminal window
#not needed if image is being pulledd from docker hub 
    docker build -t <repo|image name> <docker image location | . >
    <or>
    docker build -t <image name>:<version> <docker image location | . > # . => current dir
    #-t (tag) allows to specify a name for the image
    
    #-name is different form -t 
        #--name is used to give name for a container newly created 
        #-t is used for naminig images
        
    #then --->
    #if images is pulled from docker hub directly run this
        docker run -d -p <host port:container port> --name <container name|alias name> <repo/image name to be used>

    #adding volumes [only during dev remove before deployment]
    #<-----copies the edited project file to the container file and restarts the docker container---->
        docker run -p <host port:container port> -v <project folder full location> (src folder) : <file to be copied into the docker file>(destination folder) <repo/image name>
            #use $PWD for getting location of the current working directory in the dev machine
            #eg-> <project folder full location> : D:/project/myapp 
                 #<file to be copied into in the docker file> : /var/www/html <-folder in docker container

        #randomly assign a port to container
            docker run -d --name <container name> -p <container port> <image name>:<latest|version name>
            docker port <container name> -p <container port>

        #to directly run the container without creating a seperate instance ie container name
            docker run <image name>
    #to set env for Node
        docker run -d --name <container name> -e NODE_ENV=production -p <host port>:<container port> <image name>

        
#to access the containers terminal
    docker attach <image name>

#to get more details of the docker container
    docker inspect <given-name|container-id>
    docker log <given-name|container-id>
    docker log <given-name|container-id>
#docker network
    docker network ls #list all the network related info in all the existing containers
    docker network inspect <NAME> #NAME is a coloumn found after running docker network ls

#for containers with NAME = none 3rd party extensions which provide virtual network features can be given
    docker network create <network name>

#creating docker container with a network option
    docker container run -d --name <container name> --network <network name> <image name>
        #<network name> must be filled once the docker network create command is run
#connecting an existing container without a network parameter
    docker network connect <network name> <conainer name to connect>

#container network inspecting
    docker network inspect <container name>

#disconnecting from network
    docker network disconnect<network name> <conainer name to connect> 



#<---OnBuild--->
    #when commands have to run after a certain commands
    FROM node:7
    RUN mkdir -p /usr/src/app
    WORKDIR /usr/src/app
    ONBUILD COPY package.json /usr/src/app/
    ONBUILD RUN npm install
    ONBUILD COPY . /usr/src/app
    CMD [ "npm", "start" ]
    #or
    ENTRYPOINT["executable commands"]
   
   

    FROM node:7-onbuild
    EXPOSE 3000


#copying from one contiainer to another
    docker cp <current folder file> <docker conatiner name to be copied to>:<folder location>
#<----ignoring files---->
#ignore files such as nodemodules and packages-lock.json
#after creating the .dockerfile and .docker file and building the image

echo <file name to be ignored> >> .dockerignore


#<-------linking containers WITH LINK------->
    docker run --link <src container>:<give name to container> <container name to link>
    #docker sets env vars and hosts
    #to list env vars
        docker run --link <src container>:<give name to container> <container name to link> env
    
    #to list the hosts
        docker run --link <src container>:<give name to container> <container name to link> cat /etc/hosts
    
    #<----to connect to app such as node or .Net------>
        docker run -d -p <host port>:<container port> --link <src container name>:<short name for conatiner> <location/app name>

    #<-----connecting to cli------->
        docker run -it --link <src container>:<give name to container|alias name> <container name to link> <alias name> <container-cli> -h <alias name>
            #eg cli with redis
                docker run -it redis-server:redis redis redis-cli -h redis
        #to quit cli
            QUIT
        #to output the contents stored
            KEYS *


#<-------linking containers WITH NETWORK------->
    #to create a network
        docker network create <network name>  #all the containers related to this network will be linked with this
        
    #to connect to network
        docker run -d name=<continer name> --net=<network name> <container name>
        #connecting with alias
            docker network connect --alias <alias> <network name> <conatiner to connect> 
    
    #networks do not define any envronment vars
    #running terminal commands in containers
        docker  run --net = <network name> <container name> <command>
    #connect to app
    docker run -d -p <container port>:<host port> --net=<network name to connect> <profect file location>

    #listing in docker network
        docker network ls
    #listing ip address of containers in netwoks
        docker netwok inspect <network name>
    #disconnecting
        docker network disconnect <network name> <container to disconnect>

#importing and exporting containers
    #moving containers from machine to the other we can export it as a tar file
docker export <contianer to export> > <file name>.tar
docker import <file name>.tar

#<------------data container----------->   
        #used to store and manage data and dbs
        #https://docs.docker.com/engine/reference/commandline/create/ for more options other than -v

        docker create -v <folder> <container name> <image name from doker hub or built image with docker build>
        #copy to container
        docker cp <current local folder file> <docker conatiner name to be copied to>:<folder location>

        #mounting volumes
        docker run --volumes-from <docker container name from step 1>




            #<-----------data volumes----------->
    #docker volume allow directories to be shared between containers
    #it allows for use of of db and for large file 
    #docker vloumes allow for resatrting and sharing data between containers without lossing data
    #if the container is deleted the data stored in the volume is still present 
    
        docker run -v  <folder to save in docker location> :<src folder location> --name <container alias> -d <image name> 
        docker run -v $(pwd)|<local file loction> : <docker container file location> --name <container name> -d <image name> -p <host sys port>:<port in container>
    
    #creating a volume in local machine to map with container
        docker volume create <volume name>
    #to list the volumes created 
        docker volume ls
    #to inspect the volumes created
        docker volume inspect <volume name> 
       
    #running the docker container with the volume
        #named volume and setting location of db in container
        docker run -name <container name> -v <Volume name>:<location in docker containerr> -p <container port>:<host port> <image name>
        
    #to make to file read only
        docker run -v <folder to save in docker location> :<src folder location>:ro -it<image name>

        #if directory doesnot exist docker creates it auptomatically
        cat <src directory name> | docker exec -i <container alias> redis-cli --pipe

    #<----volume from------>
    #after creating a volume
        docker run --volumes-from <container alias from above> -it <image name to use>
    
    #<----cleanup data volumes----->
        docker volume prune
    #<----removing a data volume---->
        docker volume rm <name of volume>

    #<-----bind mounting----->
    #helps docker to use local files on machine on the container
        docker run -d --name <container name> -p <port on local machine>:<port on container> -v <location of file on local machine>:<destination folder on container> <image name>
        #use $(pwd) in place of file on local machine location
        #eg:
            docker container run -d --name my_nginx $(pwd):/usr/share/nginx/html nginx


  #<----reducing size of docker container----->
  
  # 1. changing the version of base image
    #in the dockerfile
        #while importing using "FROM" 
            FROM <base image>:<version> #instead of giving version number use alpine
            FROM <base image>:alpine #reduces size by 50%
            
   # 2. by tagging the container and making a new container
    #after importing the base image
        FROM <base image>:alpine AS <tag name>
        #in the same dockerfile after seting the woking dir
        FROM alpine
        WORKDIR <workdir name>
        COPY --from=<tag name> <previous docker image's files that need to be copied such as the working dir> <working dir| distination location of the new container>
        write the rest of the dockerfile
        
        
    
    
    
    
