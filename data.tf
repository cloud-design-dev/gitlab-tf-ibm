data "ibm_resource_group" "group" {
    name = "CDE"
}

data "ibm_cis" "cis_instance" {
  name              = "cloudintrsvc-rt"
  resource_group_id = "${data.ibm_resource_group.group.id}"
}

data "ibm_cis_domain" "cis_instance_domain" {
  domain = "cloudintrsvc.com"
  cis_id = "${data.ibm_cis.cis_instance.id}"
}

data "ibm_compute_ssh_key" "deploymentKey" {
  label = "ryan_tycho"
}

data "template_file" "cloud_init" {
  template = "${file("${path.cwd}/Templates/nfs.yml.tpl")}"

  vars = {
    nfs_mount = "${ibm_storage_file.gitlab_storage.mountpoint}"
  }
}

data "template_file" "fqdn" {
  template = "${file("${path.cwd}/Templates/gitlab-ansible.yml.tpl")}"

  vars = {
    fqdn = "${ibm_compute_vm_instance.gitlab.hostname}.${var.domain}"
    email = "${var.email}"
  }
}