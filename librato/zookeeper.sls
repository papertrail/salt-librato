{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/zookeeper.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/zookeeper.conf.jinja
    - context:
      host: {{ librato.zookeeper.host }}
      port: {{ librato.zookeeper.port }}
