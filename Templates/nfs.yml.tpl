- hosts: instances
  become: true
  tasks:
    - name: Mount File storage volume
      mount:
        path: /git-data
        src: ${nfs_mount}
        fstype: nfs4
        state: mounted
        opts: "defaults,hard,intr"