configure_usr_local_bin_profile:
  file.managed:
    - name: /etc/profile.d/usr_local_bin.sh
    - source: salt://usr_local_bin_profile/usr_local_bin.sh
