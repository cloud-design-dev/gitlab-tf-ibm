variable ibm_bx_api_key {
  type    = "string"
  default = ""
}

variable ibm_sl_username {
  type    = "string"
  default = ""
}

variable ibm_sl_api_key {
  type    = "string"
  default = ""
}

variable dnsimple_token {
  type    = "string"
  default = ""
}

variable dnsimple_account {
  type    = "string"
  default = ""
}

variable datacenter {
  type = "map"

  default = {
    us-east1  = "wdc04"
    us-east2  = "wdc06"
    us-east3  = "wdc07"
    us-south1 = "dal10"
    us-south2 = "dal12"
    us-south3 = "dal13"
  }
}

variable os_reference_code {
  type = "map"

  default = {
    u16 = "UBUNTU_16_64"
    u18 = "UBUNTU_18_64"
  }
}

variable flavor_key_name {
  type = "map"

  default = {
    medium = "B1_8X16X100"
    large  = "BL2_8X32X100"
  }
}

variable domain {
  default = "example.com"
}

variable email {
  default = "user@example.com"
}
