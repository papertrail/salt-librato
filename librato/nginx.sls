{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/nginx.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/nginx.conf.jinja
    - context:
      protocol: {{ librato.nginx.protocol }}
      host: {{ librato.nginx.host }}
      path: {{ librato.nginx.path }}
