{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/mysql.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/mysql.conf.jinja
    - context:
      databases: {{ librato.mysql.databases }}
