test:
  user.present:
    - password: test
    - hash_password: true
    - groups:
      - wheel
