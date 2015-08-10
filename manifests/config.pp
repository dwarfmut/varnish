# Backend.pp
define varnish::config (
  $host,
  $port,
  $vhost,
  $url = undef,
  $cache = undef,
  $nocache = undef,

) {

  file { "/etc/varnish/main.vcl":
    content => template("varnish/main.vcl.erb"),
    owner   => varnish,
    group   => varnish,
  }

  concat { "/etc/varnish/default.vcl":
    owner => varnish,
    group => varnish,
  }

  concat::fragment { "default":
    target  => "/etc/varnish/default.vcl",
    content => "vcl 4.0;\nimport std;\n\ninclude \"/etc/varnish/main.vcl\";\n",
    order   => 1,
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
  }


}
