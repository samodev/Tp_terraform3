#########################################################
################# CREDENTIALS ###########################

variable "subscription_id"  {}
variable "client_id"        {}
variable "client_secret"    {}
variable "tenant_id"        {}
variable "ssh_keys_data"    {}
variable "ssh_keys_path"    {}

########################################################
################### GENERAL ############################

variable "location"       {}
variable "boolean_true"   {}
variable "boolean_false"  {}

########################################################
################ RESOURCE GROUP ########################

variable "resource_group_name" {}

#########################################################
############### VIRTUAL NETWORK #########################

variable "virtual_network_name"           {}
variable "virtual_network_address_space"  {}

#########################################################
############### PUBLIC IP ###############################

variable "myterraformpublicip_name"   {}
variable "myterraformpublicip2_name"  {}
variable "address_allocation"         {}
variable "address_allocation_dynamic" {}

#########################################################
################### PRIVATE IP ##########################

variable "ip_addresses" {type="list"}

#########################################################
################## SUBNET ###############################

variable "myterraformsubnet_name" {}
variable "myterraformsubnet_address_prefix" {}

########################################################
########### NETWORK SECURITY GROUP #####################

variable "myterraformnsg_name" {}
variable "myterraformnsg2_name" {}

#########################################################
############## NETWORK INTERFACE ########################

variable "myterraformnic_name" {}
variable "myterraformnic2_name" {}
variable "myterraformnic_ip_configuration" {}
variable "myterraformnic2_ip_configuration" {}

#########################################################
############### STORAGE ACCOUNT #########################

variable "storage_account_replication_type" {}
variable "storage_account_tiers" {}

#########################################################
################ VIRTUAL MACHINE ########################

variable "myterraformfirstvm_name" {}
variable "myterraformsecondvm_name" {}
variable "virtual_machine_vm_size" {}

#########################################################
##################### TAGS ##############################

variable "environment" {}

