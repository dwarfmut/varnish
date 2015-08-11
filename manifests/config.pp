# Backend.pp
define varnish::config (
  $host,
  $port,
  $vhost,
  $url = undef,
  $cache = undef,
  $nocache = undef,

) {

  include varnish

  concat::fragment { "${title}":
    target  => '/etc/varnish/default.vcl',
    content => template('varnish/includes.vcl.erb'),
    order   => 5,
  }

  file { "/etc/varnish/${title}-site.vcl":
    content => template("varnish/sites.vcl.erb"),
    owner   => root,
    group   => root,
  }


}
