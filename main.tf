resource "azurerm_resource_group" "myterraformgroup" {
	name     = "${var.resource_group_name}"
	location = "${var.location}"
	tags {
		environment = "${var.environment}"
	}
}
resource "azurerm_virtual_network" "myterraformnetwork" {
	name                = "${var.virtual_network_name}"
	address_space       = ["${var.virtual_network_address_space}"]
	location            = "${var.location}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

	tags {
		environment = "${var.environment}"
	}
}
resource "azurerm_public_ip" "myterraformpublicip" {
	name                         = "publicIP${count.index + 1}"
	location                     = "${var.location}"
	resource_group_name          = "${azurerm_resource_group.myterraformgroup.name}"
	public_ip_address_allocation = "${var.address_allocation_dynamic}"
	count = "${length(var.ip_addresses)}"

	tags {
		environment = "${var.environment}"
	}
}
//resource "azurerm_public_ip" "myterraformpublicip2" {
//	name                         = "${var.myterraformpublicip2_name}"
//	location                     = "${var.location}"
//	resource_group_name          = "${azurerm_resource_group.myterraformgroup.name}"
//	public_ip_address_allocation = "${var.address_allocation}"
//
//	tags {
//		environment = "${var.environment}"
//	}
//}
resource "azurerm_subnet" "myterraformsubnet" {
	name = "${var.myterraformsubnet_name}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
	virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
	address_prefix = "${var.myterraformsubnet_address_prefix}"
}
resource "azurerm_network_security_group" "myterraformnsg" {
	name                = "${var.myterraformnsg_name}"
	location            = "${var.location}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

	security_rule {
		name                       = "SSH"
		priority                   = 1001
		direction                  = "Inbound"
		access                     = "Allow"
		protocol                   = "Tcp"
		source_port_range          = "*"
		destination_port_range     = "22"
		source_address_prefix      = "*"
		destination_address_prefix = "*"
	}

	tags {
		environment = "${var.environment}"
	}
}
resource "azurerm_network_security_group" "myterraformnsg2" {
	name                = "${var.myterraformnsg2_name}"
	location            = "${var.location}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

	security_rule = [ {
		name = "HTTP"
		priority = 1002
		direction = "Inbound"
		access = "Allow"
		protocol = "tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = "*"
		destination_address_prefix = "*"
	}, {
		name = "SSH"
		priority = 1003
		direction = "Inbound"
		access = "Allow"
		protocol = "tcp"
		source_port_range = "*"
		destination_port_range = "22"
		source_address_prefix = "*"
		destination_address_prefix = "*"
	} ]

	tags {
		environment = "${var.environment}"
	}
}
resource "azurerm_network_interface" "myterraformnic" {

	name = "nic${count.index + 1}"
	location = "${var.location}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
	network_security_group_id = "${azurerm_network_security_group.myterraformnsg.id}"
	count = "${length(var.ip_addresses)}"


	ip_configuration {
		name = "${var.myterraformnic_ip_configuration}"
		subnet_id = "${azurerm_subnet.myterraformsubnet.id}"
		private_ip_address_allocation = "${var.address_allocation}"
		private_ip_address = "${element(var.ip_addresses, count.index)}"
		public_ip_address_id = "${element(azurerm_public_ip.myterraformpublicip.*.id, count.index + 1)}"
	}

	tags {
		environment = "${var.environment}"
	}
}
//resource "azurerm_network_interface" "myterraformnic2" {
//	name= "${var.myterraformnic2_name}"
//	location = "${var.location}"
//	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
//	network_security_group_id = "${azurerm_network_security_group.myterraformnsg2.id}"
//
//	ip_configuration {
//		name = "${var.myterraformnic2_ip_configuration}"
//		subnet_id = "${azurerm_subnet.myterraformsubnet.id}"
//		private_ip_address_allocation = "${var.address_allocation}"
//		public_ip_address_id = "${azurerm_public_ip.myterraformpublicip2.id}"
//	}
//
//	tags {
//		environment = "${var.environment}"
//	}
//}
resource "random_id" "randomId" {
	keepers = {
		# Generate a new ID only when a new resource group is defined
		resource_group = "${azurerm_resource_group.myterraformgroup.name}"
	}

	byte_length = 8
}
resource "azurerm_storage_account" "mystorageaccount" {
	name = "diag${random_id.randomId.hex}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
	location = "${var.location}"
	account_replication_type = "${var.storage_account_replication_type}"
	account_tier = "${var.storage_account_tiers}"

	tags {
		environment = "${var.environment}"
	}
}
//resource "azurerm_storage_account" "mystorageaccount2" {
//	name = "diag${random_id.randomId.hex}"
//	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
//	location = "${var.location}"
//	account_replication_type = "${var.storage_account_replication_type}"
//	account_tier = "${var.storage_account_tiers}"
//
//	tags {
//		environment = "${var.environment}"
//	}
//}
resource "azurerm_virtual_machine" "myterraformvm" {
	name = "vm${count.index + 1}"
	location = "${var.location}"
	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
	network_interface_ids = ["${element(azurerm_network_interface.myterraformnic.*.id, count.index)}"]
	vm_size = "${var.virtual_machine_vm_size}"
	count = "${length(var.ip_addresses)}"

	storage_os_disk {
		name = "myOsDisk${count.index + 1}"
		caching = "ReadWrite"
		create_option = "FromImage"
		managed_disk_type = "Premium_LRS"
	}

	storage_image_reference {
		publisher = "Canonical"
		offer = "UbuntuServer"
		sku = "16.04.0-LTS"
		version ="latest"
	}

	os_profile {
		computer_name = "myVM"
		admin_username = "stage"
	}

	os_profile_linux_config {
		disable_password_authentication = "${var.boolean_true}"
		ssh_keys {
			path ="${var.ssh_keys_path}"
			key_data = "${var.ssh_keys_data}"
		}
	}

	boot_diagnostics {
		enabled = "${var.boolean_true}"
		storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
	}

	tags {
		environment = "${var.environment}"
	}

}
//resource "azurerm_virtual_machine" "myterraformsecondvm" {
//	name = "${var.myterraformsecondvm_name}"
//	location = "${var.location}"
//	resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"
//	network_interface_ids = ["${azurerm_network_interface.myterraformnic2.id}"]
//	vm_size = "${var.virtual_machine_vm_size}"
//
//	storage_os_disk {
//		name = "myOsDisk2"
//		caching = "ReadWrite"
//		create_option = "FromImage"
//		managed_disk_type = "Premium_LRS"
//	}
//
//	storage_image_reference {
//		publisher = "Canonical"
//		offer = "UbuntuServer"
//		sku = "16.04.0-LTS"
//		version ="latest"
//	}
//
//	os_profile {
//		computer_name = "myVM2"
//		admin_username = "stage"
//		admin_password = "cangetin123!"
//	}
//
//	os_profile_linux_config {
//		disable_password_authentication = "${var.boolean_false}"
//	}
//
//	boot_diagnostics {
//		enabled = "${var.boolean_true}"
//		storage_uri = "${azurerm_storage_account.mystorageaccount.primary_blob_endpoint}"
//	}
//
//	tags {
//		environment = "${var.environment}"
//	}
//}
