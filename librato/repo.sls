{% from "librato/map.jinja" import librato with context %}

{% if grains['os_family'] == 'RedHat' %}

librato_collectd_repo:
  pkgrepo.managed:
    - humanname: 'librato_{{ librato.repo_base }}'
    - baseurl: '{{ librato.repo_url }}{{ librato.repo_base }}/{{ librato.distro }}/{{ librato.repo_release }}/$basearch'
    - gpgcheck: 0

{% elif grains['os_family'] == 'Debian' %}

librato_collectd_repo:
  pkgrepo.managed:
    - humanname: 'librato_{{ librato.repo_base }}'
    - name: 'deb {{ librato.repo_url }}{{ librato.repo_base }}/{{ librato.platform }}/ {{ librato.dist }} main'
    - file: '/etc/apt/sources.list.d/librato_{{ librato.repo_base }}.list'
    - dist: {{ librato.dist }}
    - key_url: 'http://packagecloud.io/gpg.key'

{% endif %}
