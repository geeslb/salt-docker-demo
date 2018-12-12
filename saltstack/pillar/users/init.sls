users-formula:
  lookup:  # override the defauls in map.jinja
    root_group: root

users:
  ## Minimal required pillar values
  test:
    fullname: test

  testuser:
    fullname: Test User
    password: '$1$v6QfOh7B$bdXc9PAL4J2R70jpZ27t30'
    absent: True
    createhome: True
    groups:
      - admin
      - sudo

