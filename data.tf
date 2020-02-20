data "template_file" "cloud_init" {
  template = file("${path.cwd}/Templates/nfs.yml.tpl")

  vars = {
    nfs_mount = ibm_storage_file.gitlab_storage.mountpoint
  }
}

data "template_file" "fqdn" {
  template = file("${path.cwd}/Templates/gitlab-ansible.yml.tpl")

  vars = {
    fqdn  = "${ibm_compute_vm_instance.gitlab.hostname}.${var.domain}"
    email = var.email
  }
}

