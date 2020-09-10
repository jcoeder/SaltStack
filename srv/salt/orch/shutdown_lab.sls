/srv/salt/orch/shutdown_lab.sls
shutdown_vms:
  salt.function:
    - name: system.shutdown
    - tgt: "* and not salt-master*"
    - tgt_type: compound

shutdown_masters:
  salt.function:
    - name: system.shutdown
    - tgt: "salt-master*"
    - require:
      - shutdown_vms
