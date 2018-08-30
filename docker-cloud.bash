#login to docker colud

#go to cloud settings 
    #choose cloud platform

#go to node cluster option click on create
    #enter details
    #lables can be left blank too

<----steps to be done for every folder which has a docker file----->
#ie eg:- project folder has two sub folders website and api and have a dockerfile
#the below steps have to done seperatly for website folder and api folder 


#switch to docker hub to create a repo
    #choose create automated build #>automatically pulls the changes done from the repo
        #choose source control 
    
#go to source control website
#create a repo

#in the project folder
#run all git comands to push the code
    git init 
    git remote add origin <git clone url>
    git add .
    git commit -m "<commit>"
    git push -u origin

#back to docker hub
    #under create option choose the source control
    #click on the repo created and click on create
    #go to build settings
        #change if needed else leave in default
    #click on trigger


<----------creating docker stacks---------->
#similar to docker compose file
#go to docker cloud
#click on stack option
#type in the interactive console

    <name of service1> #create here relavent to the docker image being used
        image:'<username>/<image name found in the repo section in docker cloud>:<tag found in build details>' #tag is optional if not specifed taken as latest
        restart:always

        <name of service2> #create here relavent to the docker image being used
        image:'<username>/<image name found in the repo section in docker cloud>:<tag found in build details>' #tag is optional if not specifed taken as latest
        links: #use only if services link with each other
            - <name of service1>
        ports: #use only when content is ment to be public if not do not use this eg: api should not have this arg
            <internal port number>:<external facing port number> 

#click on create and deploy
