users-formula:
  lookup:  # override the defauls in map.jinja
    root_group: root

users:
  ## Minimal required pillar values
  test:
    fullname: test

  testuser:
    fullname: Test User
    password: '$1$YyLsQr/Y$RfVSDe3C40ik4DGHaqHhL.'
    absent: True
    createhome: True
    groups:
      - admin
      - sudo

