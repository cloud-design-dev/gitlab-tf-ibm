# gitlab-tf-ibm
Deploy a Gitlab powered server secured by a Let's Encrypt SSL Cert using Terraform and Ansible.

## First run
In order to properly configure the environment to run you will want to update the following values in `variables.tf`:

```
variable domain {
  default = "example.com" 
}

variable email {
  default = "user@example.com"
}
```



