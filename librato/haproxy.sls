{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/haproxy.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/haproxy.conf.jinja
    - context:
      socket_file: {{ librato.haproxy.socket_file }}
      proxies: {{ librato.haproxy.proxies }}
