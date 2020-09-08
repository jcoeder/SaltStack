create_directory:
  file.directory:
    - name: /srv/salt/states/napalm_config_backup/{{ opts['id'] }}/
    - makedirs: True

backup_napalm_network_configs:
  netconfig.saved:
    - name: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/{{ opts['id'] }}.txt
    - source: running
    - makedirs: True
    - replace: True
    - show_changes: True
    - create: True

git_init:
  module.run:
     - name: git.init
     - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
     - watch:
       - create_directory

git_config_set_email:
  module.run:
    - name: git.config_set
    - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
    - key: Salt.Stack
    - value: Salt.Stack@chewonice.net

git_config_set_name:
  module.run:
    - name: git.config_set
    - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
    - key: Salt.Stack
    - value: Salt.Stack

git_add_config_file:
  module.run:
     - name: git.add
     - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
     - filename: {{ opts['id'] }}.txt

git_commit:
  module.run:
     - name: git.commit
     - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
     - message: 'Automated Salt Backup'
     - onchanges:
       - backup_napalm_network_configs

git_set_remote:
  module.run:
     - name: git.remote_set
     - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
     - url: git@gitlab-1.chewonice.net:root/{{ opts['id'] }}.git

git_push:
  module.run:
     - name: git.push
     - cwd: /srv/salt/states/napalm_config_backups/{{ opts['id'] }}/
     - remote: origin
     - ref: master
