- hosts: instances
  become: true
  vars:
    gitlab_external_url: "https://${fqdn}/"
    gitlab_redirect_http_to_https: "true"
    gitlab_ssl_certificate: "/etc/letsencrypt/live/${fqdn}/cert.pem"
    gitlab_ssl_certificate_key: "/etc/letsencrypt/live/${fqdn}/privkey.pem"
    gitlab_git_data_dir: "/git-data"
    certbot_auto_renew_user: "root"
    certbot_admin_email: "${email}"
    certbot_create_if_missing: "true"
    certbot_create_method: standalone
    certbot_create_standalone_stop_services: []
    certbot_certs:
        - domains: ["${fqdn}"]
  roles:
    - { role: geerlingguy.certbot}
    - { role: geerlingguy.gitlab }
    - { role: geerlingguy.docker } # For use with Gitlab runners
  # tasks:
  #   - name: Disable Sign-Up for gitlab
  #     shell: gitlab-rails runner 'ApplicationSetting.last.update_attributes(signup_enabled: false)'