{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/postgresql.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/postgresql.conf.jinja
    - context:
      socket_file: {{ librato.postgresql.socket_file }}
      postgresql_user: {{ librato.postgresql.user }}
      databases: {{ librato.postgresql.databases }}
