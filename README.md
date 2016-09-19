# Librato Formula

This [formula](https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html) configures the Librato Agent and plugins.

## Supported Platforms

* RHEL 6 / CentOS 6
* RHEL 7 / CentOS 7
* Fedora 23
* Amazon Linux 2016.03
* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 15.04
* Ubuntu 15.10
* Ubuntu 16.04
* Debian 7
* Debian 8

## Usage

### Quickstart

1. Set the pillar attributes `librato.email` and `librato.token`
2. Include `librato` in your state file:

```yaml
include:
  - librato
```

This will install the Agent and set up the default plugins (`cpu`, `df`, `disk`, `swap`, `memory`, `load`).

### Supported Plugins

* `cpu`
* `df`
* `memory`
* `load`
* `disk`
* `swap`
* `apache`
* `nginx`
* `nginx_plus`
* `jvm`
* `memcached`
* `varnish`
* `zookeeper`
* `docker`
* `elasticsearch`
* `mongodb`
* `postgresql`
* `mysql`
* `redis`
* `haproxy`

### Including a plugin

To include a plugin, include the state in your SLS state file:

```yaml
include:
  - librato.apache
  - librato.jvm
```

All of the plugins have sane defaults, but you can modify them via pillar. An example pillar file is included at `pillar.example`.

### Using a third-party or upstream plugin that isn't available here

To use a plugin that this formula does not directly support (see list of plugins above),
simply drop the config file and plugin file in the appropriate locations.

Config location: `/opt/collectd/etc/collectd.conf.d/`

Plugin location: `/opt/collectd/share/collectd/`

## States & their Pillar attributes

Each plugin has a set of attributes that you can override.

### State: `apache`
  - `librato.apache.protocol`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.

  - `librato.apache.host`
      
    **Type**: string
      
    The hostname to use. Defaults to `localhost`.
  - `librato.apache.path`
    
    **Type**: string
    
    The path to the status page. Defaults to `/server-status`. `?auto` is automatically appended, so no need to include it.

  - `librato.apache.user`
    
    **Type**: string
    
    The username to use for password-protected status pages. Defaults to empty.
  - `librato.apache.password`
    
    **Type**: string
    
    The password to use for password-protected status pages. Defaults to empty.

### State: `docker`
  - `librato.docker.protocol`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.

  - `librato.docker.host`
    
    **Type**: string
    
    The Docker hostname. Defaults to `localhost`.
  
  - `librato.docker.port`
    
    **Type**: string
    
    The Docker port. Defaults to `2735`

### State: `elasticsearch`
  
  - `librato.elasticsearch.protocol`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `librato.elasticsearch.host`
    
    **Type**: string
    
    The ElasticSearch hostname. Defaults to `localhost`.
  
  - `librato.elasticsearch.port.`
    
    **Type**: string
    
    The ElasticSearch port. Defaults to `9200`.
  
  - `librato.elasticsearch.cluster_name`
    
    **Type**: string
    
    The ElasticSearch cluster name, if set. Defaults to `nil`.
  
  - `librato.elasticsearch.verbose`
    
    **Type**: true/false
    
    Verbosity trigger of the plugin. Defaults to `true`.

### State: `haproxy`
  - `librato.haproxy.socket_file`
    
    **Type**: string
    
    The HAProxy socket file. Defaults to `/run/haproxy/admin.sock`.
  
  - `librato.haproxy.proxies`
    
    **Type**: array
    
    The default proxies to collect. Defaults to `server`, `frontend`, `backend`.

### State: `jvm`
  - `librato.jvm.host`
    
    **Type**: string
    
    The JVM host. Defaults to `localhost`.
  
  - `librato.jvm.service_url`
    
    **Type**: string
    
    The JVM service URL to query. Defaults to `service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi`.
  
  - `librato.jvm.mbeans`
    
    **Type**: mapping
    
    Additional mbeans to collect. Defaults to empty.
    
    Format of the mapping is:
    ```yaml
    mbeans: [
      {
        name: 'mbean name'
        object_name: 'object name'
        instance_prefix': 'instance prefix (optional)',
        instance_from': 'instance from (optional)',
        values: [
          {
            type: 'value type',
            table: true|false,
            attribute: 'attribute'
            instance_prefix: 'instance prefix (optional)',
            instance_from: 'instance from (optional)'
          }
        ]
      }
    ]
    ```

### State: `memcached`
  - `librato.memcached.host`
    
    **Type**: string
    
    The memcached hostname. Defaults to `localhost`.
  
  - `librato.memcached.port`
    
    **Type**: string
    
    The memcached port. Defaults to `11211`.

### State: `mongodb`
  - `librato.mongodb.host`
    
    **Type**: string
    
    The MongoDB hostname. Defaults to `localhost`.
  
  - `librato.mongodb.port`
    
    **Type**: string
    
    The MongoDB port. Defaults to `27017`.
  
  - `librato.mongodb.user`
    
    **Type**: string
    
    The MongoDB username to connect with. Defaults to `nil`.
  
  - `librato.mongodb.password`
    
    **Type**: string
    
    The MongoDB password to connect with. Defaults to `nil`.
  
  - `librato.mongodb.databases`
    
    **Type**: array
    
    Databases to collect metrics for. Defaults to empty. `admin` database is automatically included in the array.
  
  - `librato.mongodb.name`
    
    **Type**: string
    
    Set the name of the plugin instance. Defaults to `mongodb`.

### State: `mysql`
  - `librato.mysql.databases`
    
    **Type**: mapping
    
    Databases to collect metrics for. Defaults to empty.
    
    Format of the mapping is:
    ```yaml
    databases: [
      {
        name: 'mydb'
        host: 'localhost'
        port: 3306
        user: ''
        password: ''
        innodb_stats: true
        slave_stats: false
      }
    ]
    ```

### State: `nginx`
  - `librato.nginx.protocol`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `librato.nginx.host`
    
    **Type**: string
    
    The hostname to use. Defaults to `localhost`.
  
  - `librato.nginx.path`
    
    **Type**: string
    
    The path to the status page. Defaults to `/basic_status`.

### State: `nginx_plus`
  - `librato.nginx_plus.protocol`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `librato.nginx_plus.host`
    
    **Type**: string
    
    The hostname to use. Defaults to `localhost`.
  
  - `librato.nginx_plus.path`
    
    **Type**: string
    
    The path to the status page. Defaults to `/status`.
  
  - `librato.nginx_plus.verbose`
    
    **Type**: string
    
    Verbosity on/off for the plugin. Defaults to `false`.

### State: `postgresql`
  - `librato.postgresql.socket_file` = '/var/run/postgresql'
    
    **Type**: string
    
    The PostgreSQL socket file. Defaults to `/var/run/postgresql`.
  
  - `librato.postgresql.user` = 'postgresql'
    
    **Type**: string
    
    The PostgreSQL user to connect as. Defaults to `postgresql`.
  
  - `librato.postgresql.databases` = []
    
    **Type**: mapping
    
    The databases to collect metrics for. Defaults to empty.
    
    The format of the mapping is:
    ```yaml
    databases = [
      {
        name: 'mydb'
        instance: 'baz'
        host: 'localhost'
        port: 5432
        user: ''
        password: ''
        ssl_mode: 'prefer'
      }
    ]
    ```

### State: `redis`
  - `librato.redis.host`
    
    **Type**: string
    
    The Redis hostname. Defaults to `localhost`.
  
  - `librato.redis.port`
    
    **Type**: string
    
    The Redis port. Defaults to `6379`.
  
  - `librato.redis.timeout`
    
    **Type**: string
    
    The timeout for connecting to Redis in milliseconds. Defaults to `2000`.

### State: `varnish`
  
  Varnish has no configurable attributes.

### State: `zookeeper`
  - `librato.zookeeper.host`
    
    **Type**: string
    
    The ZooKeeper hostname. Defaults to `localhost`.
  
  - `librato.zookeeper.port`
    
    **Type**: string
    
    The ZooKeeper port. Defaults to `2181`.

## Global Attributes

- `librato.email`
  
  **Type**: string
  
  The email to use for sending metrics. Use in conjunction with `token`. This attribute is required and defaults to empty.

- `librato.token`
  
  **Type**: string
  
  The API token to use for sending metrics. Use in conjunction with `email`. This attribute is required and defaults to empty.

- `librato.version`
  
  **Type**: string
  
  The version of the Librato Agent to install.

- `librato.repo_url`
  
  **Type**: string
  
  The base URL for the packages. Defaults to Librato's repo URL `https://packagecloud.io/librato/`.

- `librato.repo_base`
  
  **Type**: string
  
  The repo base to use. Defaults to Librato's repo collection `librato-collectd`.

- `librato.config_base`
  
  **Type**: string
  
  The base path for collectd's config files. Defaults to `/opt/collectd/etc`.

- `librato.plugin_config_path`
  
  **Type**: string
  
  The path for collectd's plugin configs. Defaults to `/opt/collectd/etc/collectd.conf.d`.

- `librato.hostname`
  
  **Type**: string
  
  The hostname to use for the node. Defaults to the FQDN of the node (`fqdn`).

- `librato.fqdn_lookup`
  
  **Type**: true/false
  
  Perform an FQDN lookup or not. Defaults to `false`.

- `librato.interval`
  
  **Type**: integer
  
  The global plugin polling interval in seconds. Defaults to `60`.

- `librato.use_log_file`
  
  **Type**: true/false
  
  Write collectd logs to a file. Defaults to `true`.

- `librato.use_syslog`
  
  **Type**: true/false
  
  Write collectd logs to syslog. Defaults to `false`.

- `librato.use_logstash`
  
  **Type**: true/false
  
  Write collectd logs to a logstash-formatted file. Defaults to `false`.

- `librato.log_file.log_level`
  
  **Type**: string
  
  The log level to use for `log_file`. Defaults to `info`.

- `librato.log_file.filename`
  
  **Type**: string
  
  The filename to use for `log_file`. Defaults to `/opt/collectd/var/log/collectd.log`.

- `librato.log_file.timestamp`
  
  **Type**: true/false
  
  Use timestamps in the log file or not. Defaults to `true`.

- `librato.log_file.print_severity`
  
  **Type**: true/false
  
  Include severity levels in the log file or not. Defaults to `true`.

- `librato.syslog.log_level`
  
  **Type**: string
  
  The log level to use for `syslog`. Defaults to `info`.

- `librato.logstash.log_level`
  
  **Type**: string
  
  The log level to use for `logstash`. Defaults to `info`.

- `librato.logstash.filename`
  
  **Type**: string
  
  The file name to use for `logstash`. Defaults to `/opt/collectd/var/log/collectd.json.log`

- `librato.default_plugins`
  
  **Type**: array
  
  A list of default plugins to include. Defaults to: `cpu`, `df`, `disk`, `swap`, `memory`, `load`.

## Testing

### Unit tests

No unit tests are written at this time.

### Integration tests

1. Run `kitchen test`
2. Take a break--it takes a bit to run the full suite.

The pillar test data is located in `test-pillar.yaml`.

#### Testing Amazon Linux

Testing Amazon Linux through `test-kitchen` requires a bit more setup:

1. Ensure `kitchen-ec2` is installed: `chef gem install kitchen-ec2`
2. Update `.kitchen.yml` to have the correct AWS key ID you're going to use
3. Set `security_group_ids` in the driver section to include a security group accessible from your laptop. Not setting this will use the `default` security group.
4. Set `transport.ssh_key` to the path of your SSH key. It looks for `id_rsa` by default.

## License and Authors

**Author:** Mike Julian (@mjulian)
