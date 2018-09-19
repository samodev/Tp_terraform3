#########################################################
################# CREDENTIALS ###########################

subscription_id = "483e3fb6-7be5-4715-b41c-f1f8f7d2dd2a"
client_id       = "e3ba3d8e-c9d2-48ce-bdb2-e655da0873c4"
client_secret   = "264d6bd5-b0d5-483f-ac27-181d124428a4"
tenant_id       = "e5af66ec-c0ee-41b6-bc79-e7470d8a1d16"
ssh_keys_data   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHfYmi4iacSVl5PDtAkNYHLmOq5BKy76Og16siX6JztyjUYlCsKg+i+3sY/BTeishgQ9pLyo9zIWutVTafUqfL/IELt8/sSTpviAnfxXo6D2/xFOy1SwKsSuuTabl9LDVAE4mLX9DzPECeTJXf1XZ+8YtHvcZ8jjPt/bVFxB3v08rOVe/uRDtb+yVawI2OO1XoMEPIZ2699ZpVi8N4ujo1FVR8M1+T2DKAcup4Q1Oka7a5nvS3UVQfVIQYPJ1u3HXTSVhiDy1SMv/HHhhxWzKyZfQfefnNrNZs/ZsFUWRGemgEhjLfzhTrtrceyIZY4WE+Y+Oz+SSBnZIE70TA/s5da5hM6cCU12pWpMAsvXz21ClonMcZXWhCswanuat/5xl3g4q6BrFE+QBLmnman7YUe1MzoCgH/g5zEDxDTg7rPFfR9UYywCnT4cC9dHYFahZma3+ZI9L6+7tPHbsVvy8QLKtmnVjRnxRwDSCLV2AmLHQne0Cgzep5Hxq+vDh/aNnVKukp0rcxCyC6GqRUxzq14tEOMLTOXSL+JftxHafuPNnPcTU1C/m8maxtrXCYw10FAu2ZwSTRjOH2bvQf6Fo9B1NSkK0HeM0V8nyRVcPvqNcHuAZqt8n32NEhlZP4EZkGIEKwJWAbzspftS3sGogaMyAXf7TWVY+kJkKH/BeXWw== samodev1725@gmail.com"
ssh_keys_path   = "/home/stage/.ssh/authorized_keys"

########################################################
#################### GENERAL ###########################

location      = "eastus"
boolean_true  = "true"
boolean_false = "false"

########################################################
################ RESOURCE GROUP ########################

resource_group_name = "myResourceGroup"

#########################################################
############### VIRTUAL NETWORK #########################

virtual_network_name          = "myVnet"
virtual_network_address_space = "10.0.0.0/16"

#########################################################
################ PUBLIC IP ##############################

myterraformpublicip_name  = "myPublicIP"
myterraformpublicip2_name = "myPublicIP2"
address_allocation        = "Static"
address_allocation_dynamic        = "dynamic"

#########################################################
################# PRIVATE IP ############################

ip_addresses = ["10.0.2.5", "10.0.2.6", "10.0.2.7", "10.0.2.8"]

#########################################################
################## SUBNET ###############################

myterraformsubnet_name = "mySubnet"
myterraformsubnet_address_prefix = "10.0.2.0/24"

#########################################################
############## NETWORK SECURITY GROUP ###################

myterraformnsg_name = "myNetworkSecurityGroup"
myterraformnsg2_name = "myNetworkSecurityGroup2"

#########################################################
############### NETWORK INTERFACE #######################

myterraformnic_name = "myNIC"
myterraformnic2_name = "myNIC2"
myterraformnic_ip_configuration = "myNicConfiguration"
myterraformnic2_ip_configuration = "myNic2Configuration"



#########################################################
############## STORAGE ACCOUNT ##########################

storage_account_replication_type = "LRS"
storage_account_tiers = "Standard"

#########################################################
############### VIRTUAL MACHINE #########################

myterraformfirstvm_name = "myVM"
myterraformsecondvm_name = "myVM2"
virtual_machine_vm_size = "Standard_DS1_v2"

#########################################################
##################### TAGS ##############################

environment = "Terraform Demo"

