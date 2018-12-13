base:
  '*':
    - common

{%- do salt.log.error('testing jinja logging *********************************') -%}



{% set apps = salt['pillar.get']('applications') %}
{%- do salt.log.error( apps) -%}
{% set appkeys = salt['pillar.get']('applications').keys() %}

{%- do salt.log.error( appkeys ) -%}
{% for app in appkeys %}

{%- do salt.log.error('applications looop for '+ app ) -%}
{%- do salt.log.error('applications:'+ app +':servers') -%}

{% set serverlist = salt['pillar.get']('applications:'+ app +':servers') %}
{%- do salt.log.error(serverlist) -%}
{% for srvtmp in serverlist %}

{%- do salt.log.error( "in for loop srvtmp " + srvtmp ) -%}

{% if todo2 is defined %}

{%- do salt.log.error( "found todo2 - looking for " + srvtmp ) -%}

{% if srvtmp in todo2 %}

{%- do salt.log.error( todo2 ) -%}
{%- do salt.log.error( srvtmp +" found appending" ) -%}
{% set appt = todo2[srvtmp] %}
{%- do salt.log.error( "37 appending " + app ) -%}
{%- do appt.append(app) -%}
{%- do salt.log.error( "40 appending " + app ) -%}
{% set todo2=todo2.__setitem__(srvtmp,appt) %}

{% else %}

{%- do salt.log.error( srvtmp +" not found  adding " +srvtmp  ) -%}
{%- do todo2.update({srvtmp :[app]}) %}
{%- do salt.log.error( "todo2 new val" ) -%}

{%- do salt.log.error( todo2 ) -%}

{% endif %}

{% else %}

{%- do salt.log.error( "todo create " + srvtmp + " val " + app ) -%}

{% set todo2 = { srvtmp:[app] } %}

{%- do salt.log.error( todo2 ) -%}
{%- do salt.log.error( todo2[srvtmp] ) -%}

{% endif %}

{%- do salt.log.error( "todo2 array" ) -%}
{%- do salt.log.error( todo2 ) -%}
{% endfor %}

{% endfor %}
{%- do salt.log.error( " todo array" ) -%}
{%- do salt.log.error( todo2 ) -%}
{% set test22 = [('minion_master', ['webmin','nano']), ('minion1', ['webmin'])] %}
{% set test23 = {'minion_master': ['webmin','nano'], 'minion1': ['webmin']} %}
{%- do salt.log.error( test22 ) -%}
{%- do salt.log.error( test23 ) -%}
{%- do salt.log.error( test23['minion1'] ) -%}
{%- do salt.log.error( todo2 ) -%}

{% for server,app in test22 %}
  {{server}}:
    - nano
    - vim
{% endfor %}    

