install_pip:
  pkg.installed:
    - name: python3-pip

install_ansible:
  pip.installed:
    - name: ansible
    - require:
      - pkg: python3-pip
