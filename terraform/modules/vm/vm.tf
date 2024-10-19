resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = file("ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDG2MrctrNoWTFfD0OAzaIUjvwaCtc3qJRpzjblonCd6GmcaUkjaKq8ngDiIWrahpRUBU5DD3/Txz3Q0iQvHk9TCSNaIwM7vEto61vzz8kVH00cGmSHKagBbWObE3LG/KALDFdPBSGXboTsfuC8z+PNRbqhcP8f25heivURQ5sYe3FqTS/hY/b4f6cX2ZWEOZlNABsj9EIci4tJ0XtlZEAkWtujVgCf5sRVKyaAn/LCQN/ZVvNjpnx7Ad8xw5GlvBl0gVkuRfHP4Wnuu7hqTW/pdRAuKINn2rezIOFz1xFX2JumT5U0oUbLPuOY/zfKFwhRns3qvgy3wVDpRhKEIkX0YzXHOBkxVMmcP9c+dAVuDIQ7n0uiOE+Gr1ODua8QlFfhzOpqusoRESkvkuollVCqf29sFNKNGh7t460dz5bFnFBIlz306YxsFn7UyXBwK5zK4yn1ctn7SlDp2iGfDbgKj7ydoKIMWRQy0Ho39JIyp8AYXyNoPC5tHXtSjY8BRgk= minhhuy@DESKTOP-HBO441V")
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
