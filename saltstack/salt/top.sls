base:
  '*':
    - common

# I added lots of DEBUG in here , look at /var/log/salt/minion
# DEBUG will show up as ERROR , good for Jinja troubledhooting
# Also like command salt 'minion' slsutil.renderer /srv/salt/top.sls 'jinja'
{%- do salt.log.error("BEGIN ************************************") -%}
# A dictionary of applications secrtion of pillar
{% set APPLICATIONS = salt['pillar.get']('applications') %}
# DEBUG - Print Application list
{%- do salt.log.error( APPLICATIONS) -%}
# Get list of Keys, this will be all appication names
{% set APPKEYS = salt['pillar.get']('applications').keys() %}

# creatred a na key to prevent issues with empty array
# This is a dictionary with a list as it's items
# the list is a list of applications
{% set StateList = {"na":["nas"] } %}
{%- do salt.log.error( APPKEYS ) -%}
# We will itterate through every application
{% for APP in APPKEYS %}

# DEBUG - Get Application from Pillar
{%- do salt.log.error('applications:'+ APP +':servers') -%}

{% set SERVERLIST = salt['pillar.get']('applications:'+ APP +':servers') %}
# DEBUG - Get Server from Pillar
{%- do salt.log.error(SERVERLIST) -%}
# We will itterate through every server
{% for SERVER  in SERVERLIST %}

# Get array of APPLICATIONS if SERVER is already in StateList
{% if SERVER in StateList %}
{% set SERVERAPPS = StateList[SERVER] %}
# Otherwise create empty list
{% else %}
{% set SERVERAPPS = [] %}
{% endif %}

# append application name to list
{%- do SERVERAPPS.append(APP) -%}
{# another way to add items to a dictionary
{%- do StateList.__setitem__(SERVER ,SERVERAPPS) -%}
#}
{%- do salt.log.error( "StateList new val" ) -%}
# Add Server and list to dictionary
{%- do StateList.update({SERVER :SERVERAPPS}) -%}
# DEBUG print disctionary
{%- do salt.log.error( "StateList Dictionary - SERVERAPPS for loop" ) -%}
{%- do salt.log.error( StateList ) -%}

{% endfor %}
{% endfor %}

# delete an item from dictionary
{%- do StateList.pop("na") -%}
# adding an item to dictionary
{%- do StateList.update({"test":["test"]}) -%}
# delete an item from dictionary
{%- do StateList.pop("test") -%}
# DEBUG print dictionary
{%- do salt.log.error( "StateList Dictionary" ) -%}
{%- do salt.log.error( StateList ) -%}

{% for server in StateList %}
  {{server}}:
{% for appname in StateList[server] %}
{% set APPCMD = salt['pillar.get']('applications:' + appname + ':runcmd') %}

{% if APPCMD == "" %}
{% set APPCMD = appname %}
{%- do salt.log.error( "Set APPCMD to default") -%}
{% endif %}

{##}
    - {{APPCMD}}
{% endfor %}    
{% endfor %}    

