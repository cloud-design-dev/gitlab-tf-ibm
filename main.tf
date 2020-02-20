resource "ibm_storage_file" "gitlab_storage" {
  type              = "Endurance"
  datacenter        = var.datacenter["us-east3"]
  capacity          = 100
  iops              = 2
  snapshot_capacity = 10
  hourly_billing    = true
  notes             = "Used for testing Gitlab server deployment via Terraform and Ansible"

  snapshot_schedule {
    schedule_type   = "WEEKLY"
    retention_count = 20
    minute          = 2
    hour            = 13
    day_of_week     = "SUNDAY"
    enable          = true
  }
  snapshot_schedule {
    schedule_type   = "HOURLY"
    retention_count = 20
    minute          = 2
    enable          = true
  }
}

resource "local_file" "cloud_init_rendered" {
  content = <<EOF
${data.template_file.cloud_init.rendered}
EOF


  filename = "${path.cwd}/Playbooks/nfs.yml"
}

resource "ibm_compute_vm_instance" "gitlab" {
  hostname             = "gitlab"
  domain               = var.domain
  user_metadata        = file("${path.cwd}/install.yml")
  os_reference_code    = var.os_reference_code["u18"]
  datacenter           = var.datacenter["us-east3"]
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  flavor_key_name      = var.flavor_key_name["large"]
  file_storage_ids     = [ibm_storage_file.gitlab_storage.id]

  tags = [
    "gitlab",
    "ryantiffany",
  ]
}

resource "dnsimple_record" "gitlab_dns" {
  domain = var.domain
  name   = "gitlab"
  value  = ibm_compute_vm_instance.gitlab.ipv4_address
  type   = "A"
  ttl    = 3600
}

resource "local_file" "fqdn_rendered" {
  content = <<EOF
${data.template_file.fqdn.rendered}
EOF


  filename = "${path.cwd}/Playbooks/deploy-gitlab.yml"
}

resource "local_file" "ansible_inventory" {
  depends_on = [local_file.fqdn_rendered]

  content = <<EOF
[instances]
gitlab ansible_host=${ibm_compute_vm_instance.gitlab.ipv4_address} ansible_user=deployer

[instances:vars]
host_key_checking = False
retry_files_enabled = False

[local]
control ansible_connection=local

EOF


  filename = "${path.cwd}/Playbooks/inventory"
}

