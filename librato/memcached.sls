{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/memcached.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/memcached.conf.jinja
    - context:
      host: {{ librato.memcached.host }}
      port: {{ librato.memcached.port }}
