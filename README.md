# gitlab-tf-ibm
Deploy a Gitlab powered server secured by a Let's Encrypt SSL Cert using Terraform and Ansible.

## Prerequisites
 - A domain hosted at [DNSimple](https://dnsimple.com). 
 - Terraform and Ansible installed locally.
 - The SSH key of the server you are running this example on. 

> Note: If you use a different DNS hosting service you can check the [Terraform Providers](https://www.terraform.io/docs/providers/index.html) to see if they are supported. You will need to update the `variables.tf`, `main.tf`, and `providers.tf` files accordingly.

## Initial Configuration
In order to properly configure the environment to run you will want to update the following values in `variables.tf`:

 - Replace `example.com` with the domain that you would like to use.
 - Replace `user@example.com` with a valid email address

You will also need to update the `install.yml` file to include your SSH-key. 

```
    ssh-authorized-keys:
    - 'ssh-rsa example-key'
```

## Outline of steps
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
 - Install Certbot and generate a [Let's Encrypt Certificate](https://letsencrypt.org/) (set up to autorenew by default)
 - Install and configure [Gitlab](https://about.gitlab.com/stages-devops-lifecycle/)
 - Secure Gitlab with the Let's Encrypt Certificate
 - Install Docker for use as a Gitlab Runner 
 
## Deploying Gitlab using Terraform
**Grab example repo**
Clone this example repo to your local system

```
git clone https://github.com/cloud-design-dev/gitlab-tf-ibm.git
cd gitlab-tf-ibm
```

**Configure credentials.tfvars file for authentication with IBM Cloud**
Copy the example `credentials.tfvars.tpl` to `credentials.tfvars` and then update `credentials.tfvars` with the appropriate IBM Cloud and SL API information. 

```
cp credentials.tfvars.tpl credentials.tfvars
nano/vi credentials.tfvars
```

**Initialize Terraform** 
```
terraform init 
```

**Plan deployment and save to file**

```
terraform plan -var-file='./credentials.tfvars` -out gitlab.tfplan
```

**Apply deployment plan** 

```
terraform apply gitlab.tfplan
```

## Run Ansible Playbooks 

```
ansible-playbook -i Playbooks/inventory.env Playbooks/deploy-environment.yml
```
