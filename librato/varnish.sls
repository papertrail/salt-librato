{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/varnish.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/varnish.conf.jinja
