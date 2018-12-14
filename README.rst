=================
Salt Docker Demo
=================

A Salt Demo using Docker.


Instructions
============

This will need the molten formula

https://github.com/saltstack-formulas/molten-formula
 

after cloning this you must extract formulas to salt/formulas folders
I did this because I didn't want to include other git projects as sub folders


Run the following commands in a terminal. Git, Docker, and Docker Compose need
to already be installed.

.. code-block:: bash

    git clone https://github.com/gtmanfred/salt-docker-demo.git
    cd salt-docker-demo
    cd saltstack\salt\formulas
    git clone https://github.com/saltstack-formulas/molten-formula
    docker-compose up -d


This will download the centos 7 docker image and create four docker
containers.  One will be a Salt Master named `minion_master` and two will be Salt
Minions named `minion1` and `minion2`.  There vill also be a 'vault' server for testing vault. 
The Salt Minions will point to the Salt Master and the minions keys will already be accepted. 
Because the keys are pre-generated and reside in the repo, please be sure to regenerate new keys if
you use this for production purposes.

You can then run the following commands to log into the Salt Master and begin
using Salt.

.. code-block:: bash

    docker-compose exec salt bash
    salt \* test.ping
