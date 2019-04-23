# gitlab-tf-ibm
Deploy a Gitlab powered server secured by a Let's Encrypt SSL Cert using Terraform and Ansible.

## Prerequisites
 - A supported [Terraform DNS Provider](https://www.terraform.io/docs/providers/index.html) to properly create the Gitlab DNS record OR an IBM Cloud CIS instance
 - The SSH key of the server you are running this example on. 

## Initial Configuration
In order to properly configure the environment to run you will want to update the following values in `variables.tf`:

 - Replace `example.com` with the domain that you would like to use.
 - Replace `user@example.com` with a valid email address

You will also need to update the `install.yml` file to include your SSH-key. 

```
    ssh-authorized-keys:
    - 'ssh-rsa example-key'
```

## Steps
The deployment example will do the following

### Terraform
Terraform will be used to:
 - Spin up Infrastructure and create DNS record 
 - Spin up File storage to be used as Gitlab data storage (also sets up automatic snapshots)
 - Generate custom Ansible Playbooks
 
### Ansible
Ansible will be used to:
 - Update the base operating system
 - Mount the File storage share to `/git-data`
 - Install Certbot and generate a Let's Encrypt Certificate (set up to autorenew by default)
 - Install and configure [Gitlab]()
 - Secure Gitlab with the Let's Encrypt Certificate
 
 
