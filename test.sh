#!/bin/bash

set -e

if ! command -v az &> /dev/null
then
    echo "Azure CLI is not installed. Please install it to proceed."
    exit 1
fi


read -p "Enter your Resource Group name: " RG_name
read -p "Enter your desired location[default:eastus]: " location
read -p "Enter your Storage account name: " STA_name 
read -p "Enter your Virtual Machine name: " VM_name

location=${location:-eastus}

echo "Your Resource Group name is $RG_name"
echo "Your storage account name is $STA_name"
echo "Your VM name is $VM_name"
echo "Your location is $location"

az group create --name "$RG_name" --location "$location"
az storage account create --name "$STA_name" --resource-group "$RG_name" --location "$location" --sku Standard_LRS --kind StorageV2
az vm create --resource-group "$RG_name" --name "$VM_name" --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

echo "all resources created successfully"



