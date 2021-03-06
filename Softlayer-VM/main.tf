#####################################################################
##
##      Created 12/30/18 by admin. for Softlayer-VM
##      Credentials taken from the CAM connection
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

provider "ibm" {
    version = "~> 0.7"
}


resource "ibm_compute_vm_instance" "vm_instance" {
  cores = 1
  memory      = 1024
  domain      = "${var.vm_instance_domain}"
  hostname    = "${var.vm_instance_hostname}"
  datacenter  = "${var.vm_instance_datacenter}"
  ssh_key_ids = ["${ibm_compute_ssh_key.ibm_cloud_temp_public_key.id}"]
  os_reference_code = "${var.vm_instance_os_reference_code}"
  network_speed = "1000"
  hourly_billing = "true"
  local_disk = "false"
  disk_size = 100
  disks = [100]
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "ibm_compute_ssh_key" "ibm_cloud_temp_public_key" {
  label = "ibm-cloud-temp-public-key"
  public_key = "${tls_private_key.ssh.public_key_openssh}"
}
