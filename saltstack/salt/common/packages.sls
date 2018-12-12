common_packages:
  pkg.installed:
    - pkgs:
      - htop
      - strace
      - vim-enhanced
      - nano
      - rsyslog
      - net-tools

rsyslog:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: rsyslog
