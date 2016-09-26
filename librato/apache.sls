{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/apache.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/apache.conf.jinja
    - context:
      protocol: {{ librato.apache.protocol }}
      host: {{ librato.apache.host }}
      path: {{ librato.apache.path }}
      {% if salt['pillar.get']('librato.apache.user', False) %}
      apache_user: {{ librato.apache.user }}
      {% endif %}
      {% if salt['pillar.get']('librato.apache.password', False) %}
      apache_password: {{ librato.apache.password }}
      {% endif %}
