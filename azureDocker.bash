#to create a container
az container create \
  --resource-group <resource group id > \
  --name <container name> \
  --image <docker image name> \
  --ip-address Public \
  --restart-policy <policy option> \
  --location <azure site to be used> \
  --environment-variables | secure-environment-variables \
    <var name1>=$<var name1> \
    <var name2>=$<var name2>

#restart-policy
    #Always - container group are always restarted. default. mostly used for containers which have to kepp running
    #Never  - never restarted. containers runonly once
    #OnFailure - Containers in the container group are restarted only when the process executed in the container fails 

az container show \
>   --resource-group <resource group id> \
>   --name <contianer name> \
>   --query "{FQDN:ipAddress.fqdn,ProvisioningState:provisioningState}" \
>   --out table

#show the container status
az container show \
  --resource-group <resource group id> \
  --name <contianer name> \
  --query containers[0].instanceView.currentState.state | <ant parameter used while creating contianer>

#to check container logs
az container logs \
  --resource-group <resource group id> \
  --name <container name>

--ip-address Public \