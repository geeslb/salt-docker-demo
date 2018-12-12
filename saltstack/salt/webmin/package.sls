install_webmin_from_rpm:
  pkg.installed:
    - sources:
      - webmin: https://prdownloads.sourceforge.net/webadmin/webmin-1.900-1.noarch.rpm 


Add_test_user_to_webmin:
  file.append:
    - name: /etc/webmin/miniserv.users
    - text: "test:x:0"


set_test_user_passwd_webmin:
  cmd.run:
    - name : /usr/libexec/webmin/changepass.pl /etc/webmin test test
    - require-in: 
      - file: Add_test_user_to_webmin


