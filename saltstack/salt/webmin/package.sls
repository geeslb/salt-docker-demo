install_webmin_from_rpm:
  pkg.installed:
    - sources:
      - webmin: https://prdownloads.sourceforge.net/webadmin/webmin-1.900-1.noarch.rpm 

