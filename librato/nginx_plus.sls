{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/nginx_plus.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/nginx_plus.conf.jinja
    - context:
      protocol: {{ librato.nginx_plus.protocol }}
      host: {{ librato.nginx_plus.host }}
      path: {{ librato.nginx_plus.path }}
      verbose: {{ librato.nginx_plus.verbose }}
