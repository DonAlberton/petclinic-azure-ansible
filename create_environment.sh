source constants.sh

### CREATE ENVIRONMENT

# CREATE RESOURCE GROUP
az group create --name $RESOURCE_GROUP --location germanywestcentral
# END

# CREATE ANSIBLE VM
az vm create \
--resource-group $RESOURCE_GROUP \
--name ansible --location northeurope \
--image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
--size Standard_B1s \
--admin-username azureuser \
--admin-password Losowehaslo123! \
--private-ip-address 10.0.0.100 \
--public-ip-address ansiblePublicIp \
--generate-ssh-keys

# CREATE DATABASE VM
az vm create \
--resource-group $RESOURCE_GROUP \
--name database --location northeurope \
--image Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2:latest \
--size Standard_B1s \
--admin-username azureuser \
--admin-password Losowehaslo123! \
--private-ip-address 10.0.0.20 \
--public-ip-address "" \
--nsg ansibleNSG 


ansible_public_ip=$(az network public-ip show --name ansiblePublicIp \
--resource-group $RESOURCE_GROUP \
--query ipAddress \
--output tsv) 
### END

### COPY FILES
scp -o "StrictHostKeyChecking no" install-docker.yaml inventory run_container.yaml initDB.sql azureuser@$ansible_public_ip:/home/azureuser/
### END

### CONFIGURE ANSIBLE MACHINE
az vm run-command invoke --resource-group $RESOURCE_GROUP \
--name ansible \
--command-id RunShellScript \
--scripts @ansible_installation.sh
### END
