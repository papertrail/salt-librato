{% from "librato/map.jinja" import librato with context %}

{{ librato.plugin_config_path }}/elasticsearch.conf:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://librato/files/elasticsearch.conf.jinja
    - context:
      protocol: {{ librato.elasticsearch.protocol }}
      host: {{ librato.elasticsearch.host }}
      port: {{ librato.elasticsearch.port }}
      {% if salt['pillar.get']('librato.elasticsearch.cluster_name', False) %}
      cluster_name: {{ librato.elasticsearch.cluster_name }}
      {% endif %}
      verbose: {{ librato.elasticsearch.verbose }}
