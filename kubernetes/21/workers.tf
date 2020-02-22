# Creamos los controllers

resource "upcloud_server" "worker" {
  zone     = "us-sjo1"
  count    = "${var.worker_count}"
  hostname = "worker-${count.index}"
  cpu      = "4"
  mem      = "4096"

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
    #storage = "01a0d2d1-657f-43ac-8e37-bc0a7b0447cd"
    #storage = "CoreOS Stable 1068.8.0"
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
    inline    = [
      "chmod +x /home/tf/install-kubeadm.sh",
      "sudo /home/tf/install-kubeadm.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo kubeadm join ${local.kube_master} --token ${local.kubeadm_token} --discovery-token-unsafe-skip-ca-verification"
      #"kubeadm init --token ${local.kubeadm_token}"
    ]
  }

  depends_on = ["upcloud_server.controller"]

}

# output "public_ip_workers" {
#   value = "${element(upcloud_server.worker.*.ipv4_address, 0)}"
# }

# resource "null_resource" "worker" {
#   count         = "${var.worker_count}"
#   connection {
#     host        = "${element(upcloud_server.worker.*.ipv4_address, count.index)}"
#     type        = "ssh"
#     user        = "tf"
#     private_key = "${file("id_rsa")}"
#   }

#   depends_on        = ["null_resource.controller"]

#   provisioner "kubeadm" {
#     config = "${kubeadm.main.config}"
#     join   = "${element(upcloud_server.controller.*.ipv4_address, 0)}"
#     role   = "worker"
#     #nodename = "${self.private_dns}"

#     ignore_checks = [
#       "KubeletVersion",  // the kubelet version in the base image can be very different
#     ]

#     install {
#       auto = true
#     }
#   }
# }
