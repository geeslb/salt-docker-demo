applications:
  webmin:
    servers:
      - minion_master
      - minion1
      - minion2
  molten:
    servers:
      - minion_master
    runcmd: molten.full
  
    
