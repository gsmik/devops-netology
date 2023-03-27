resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


/*data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "platform" {
  name        = "netology-develop-platform-web"
  platform_id = "standard-v1"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
*/
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_instance.name
  platform_id = var.vm_web_instance.platform_id
  resources {
    cores         = var.vm_web_instance.resources.cores
    memory        = var.vm_web_instance.resources.memory
    core_fraction = var.vm_web_instance.resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_instance.scheduling_policy.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_instance.network_interface.nat
  }
metadata = {
    serial-port-enable = var.vm_web_instance.metadata.serial-port-enable
    ssh-keys           = "${var.vms_ssh_user}:${var.vms_ssh_root_key}"
  }
}
/*}
  metadata = {_
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}
*/
#
#-----db-----
data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image
}
resource "yandex_compute_instance" "platform_db" {
  name        = var.vm_db_instance.name
  platform_id = var.vm_db_instance.platform_id
  resources {
    cores         = var.vm_db_instance.resources.cores
    memory        = var.vm_db_instance.resources.memory
    core_fraction = var.vm_db_instance.resources.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_instance.scheduling_policy.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_db_instance.network_interface.nat
  }
  metadata = {
    serial-port-enable = var.vm_db_instance.metadata.serial-port-enable
    ssh-keys           = "${var.vms_db_ssh_user}:${var.vms_db_ssh_root_key}"
  }
}
