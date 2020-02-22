# Creamos los controllers

resource "random_string" "kubeadm_token_1" {
  length  = 6
  special = false
  upper   = false
}

resource "random_string" "kubeadm_token_2" {
  length  = 16
  special = false
  upper   = false
}

locals {
  kubeadm_token = "${random_string.kubeadm_token_1.result}.${random_string.kubeadm_token_2.result}"
  kube_master   = "${element(upcloud_server.controller.*.ipv4_address, 0)}:6443"
}

resource "upcloud_server" "controller" {
  zone     = "us-sjo1"
  count    = "1"
  hostname = "controller-${count.index}"
  cpu      = "4"
  mem      = "8192"

  login {
    user            = "tf"
    keys            = [ "${file("id_rsa.pub")}" ]   # Este archivo tiene que estar presente en este mismo directorio
    create_password = false
  }

  storage_devices {
    size    = 50
    action  = "clone"
    tier    = "maxiops"
    # Template UUID for Ubuntu 18.04
    storage = "01000000-0000-4000-8000-000030080200" 
  }

  connection {
    host        = "${self.ipv4_address}"
    type        = "ssh"
    user        = "tf"
    private_key = "${file("id_rsa")}"
  }

  provisioner "file" {
    source      = "install-kubeadm.sh"
    destination = "/home/tf/install-kubeadm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/tf/install-kubeadm.sh",
      "sudo /home/tf/install-kubeadm.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo kubeadm init --token ${local.kubeadm_token}",
      "sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
    ]
  }

}

output "public_ip_controller" {
  value = "${element(upcloud_server.controller.*.ipv4_address, 0)}"
}



# this provisioner will start a Kubernetes master in this machine,
# with the help of "kubeadm" 

# resource "null_resource" "controller" {
#   count         = "${var.controller_count}"
#   depends_on    = ["upcloud_server.controller"]
#   connection {
#     host        = "${element(upcloud_server.controller.*.ipv4_address, count.index)}"
#     type        = "ssh"
#     user        = "tf"
#     private_key = "${file("id_rsa")}"
#   }

#   provisioner "kubeadm" {
#     config = "${kubeadm.main.config}"
#     role   = "master"
# #    join      = "${count.index == 0 ? "" : aws_instance.masters.0.private_ip}"

#     #nodename = "${self.private_dns}"

#     ignore_checks = [
#       "KubeletVersion",  // the kubelet version in the base image can be very different
#     ]

#     install {
#       auto = true
#     }
#   }
# }