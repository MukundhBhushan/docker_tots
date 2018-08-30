install docker

basic commands
    docker run -d -p <port:no> --name <image name to use in terminal> <repo/image name> #runs a container -p is used when a web app needs to be opened in the browser
    #-d starts container in detached mode use docker attach <image name> to use containers terminal
    docker start <name/id> #starts a container which is not running
                           #used to restart a container whose image is already created (ie after docker run is executed)
    docker stop <name/id> #shut down
    docker ps -a #-a to list stoped containers too
    docker rm <name/id> #removes the image


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

RUN <terminal commands> #to create a file/folder 
ADD  #add/change file to existing folder or directories no terminal commands 
     #eg to change file ./nginx.conf() <space> /etc/nginx/conf.d/default.conf -> changes default.cong with nginx.conf

EXPOSE <port number>

#<-----building docker image---->
#in the previously opened terminal window
docker build -t <repo/image name> <project folder path>

    #then --->
        docker run -d -p <port:no> --name <image name to use in terminal> <repo/image name>

    #adding volumes [only during dev remove before deployment]
    #<-----copies the edited project file to the container file and restarts the docker container---->
        docker run -p <port:number> -v <project folder full location>(src folder) : <file to be copied into the docker file>(destination folder) <repo/image name>
            #eg-> <project folder full location> : D:/project/myapp 
                 #<file to be copied into in the docker file> : /var/www/html <-folder in docker container

#to access the containers terminal
    docker attach <image name>



