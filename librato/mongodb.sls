{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/mongodb.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/mongodb.conf.jinja
    - context:
      host: {{ librato.mongodb.host }}
      port: {{ librato.mongodb.port }}
      {% if salt['pillar.get']('librato.mongodb.user', False) %}
      mongodb_user: {{ librato.mongodb.user }}
      {% endif %}
      {% if salt['pillar.get']('librato.mongodb.password', False) %}
      mongodb_password: {{ librato.mongodb.password }}
      {% endif %}
      databases: {{ librato.mongodb.databases }}
      mongodb_name: {{ librato.mongodb.name }}
