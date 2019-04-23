- hosts: all:!control
  become: true
  tasks:
    - name: Mount File storage volume
      mount:
        path: /git-data
        src: ${nfs_mount}
        fstype: nfsv4
        state: mounted
        opts: "defaults,hard,intr"