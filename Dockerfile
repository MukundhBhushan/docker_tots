#Use an existing image as base 
FROM <base image>:<version> 
#eg: nginx:alpine


#copy src files to container
COPY <src folder in pc> <dest folder in container>

# download dependencies
RUN <commands> #shell commands suchas installing packages

CMD ["<command1>","<command2>"] 
#give: command1 command2

ENTRYPOINT [ "executable commands" ] 
#no ',' needed to seperate 
#CMD, ENTRYPOINT for running shell commands based on the image such as startin nginx server

WORKDIR <folder location>
EXPOSE <port to expose>

