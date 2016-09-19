{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/docker.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/docker.conf.jinja
    - context:
      protocol: {{ librato.docker.protocol }}
      host: {{ librato.docker.host }}
      port: {{ librato.docker.port }}
