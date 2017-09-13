{% from "librato/map.jinja" import librato with context %}

include:
  - librato.repo

collectd-core:
  pkg.installed:
    - version: {{ librato.version }}
    - require:
      - pkgrepo: librato_collectd_repo

{% set email = salt['pillar.get']('librato:email') %}
{% set token = salt['pillar.get']('librato:token') %}

{{ librato.config_base }}/collectd.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/collectd.conf.jinja
    - context:
      plugin_config_path: {{ librato.plugin_config_path }}
      {% if salt['pillar.get']('librato:hostname', False) %}
      hostname: {{ librato.hostname }}
      {% endif %}
      fqdn_lookup: {{ librato.fqdn_lookup }}
      interval: {{ librato.interval }}
    - require:
      - pkg: collectd-core

{{ librato.plugin_config_path }}/logging.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/logging.conf.jinja
    - context:
      use_syslog: {{ librato.logging.use_syslog }}
      use_log_file: {{ librato.logging.use_log_file }}
      use_logstash: {{ librato.logging.use_logstash }}
      syslog: {{ librato.logging.syslog }}
      log_file: {{ librato.logging.log_file }}
      logstash: {{ librato.logging.logstash }}
    - require:
      - pkg: collectd-core

{{ librato.plugin_config_path }}/librato.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/librato.conf.jinja
    - context:
      email: {{ email }}
      token: {{ token }}
    - require:
      - pkg: collectd-core

{% for plugin in librato.default_plugins %}
{{ librato.plugin_config_path }}/{{ plugin }}.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/{{ plugin }}.conf.jinja
    - require:
      - pkg: collectd-core
{% endfor %}

collectd:
  service.running:
    - enable: True
    - require:
      - pkg: collectd-core
    - watch:
      - file: {{ librato.config_base }}/collectd.conf
      - file: {{ librato.plugin_config_path }}/*
