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
  
  if $host !~ /\b^([0-9]{1,3}\.){3}[0-9]{1,3}\b/ {
    fail("Address $host not is IP in $title backend configuration")
  }

  if $url =~ /^\/$/ {
    fail("You can not set / in URL config in $title configuration")
  }

  concat::fragment { "${title}":
    target  => '/etc/varnish/default.vcl',
    content => template('varnish/includes.vcl.erb'),
    order   => 5,
  }

  file { "/etc/varnish/${title}-site.vcl":
    content => template("varnish/sites.vcl.erb"),
    owner   => root,
    group   => root,
    notify  => Service["varnishd"],
<<<<<<< HEAD
  }

  varnish::haproxy { $title:
    vhost => $vhost,
=======
>>>>>>> 6f06dd33824d29389ecc609ee0ee8de9f2865b71
  }

}
