{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/jvm.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/jvm.conf.jinja
    - context:
      service_url: {{ librato.jvm.service_url }}
      host: {{ librato.jvm.host }}
      {% if librato.jvm.mbeans is defined %}
      mbeans: {{ librato.jvm.mbeans }}
      {% endif %}
