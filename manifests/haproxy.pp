define varnish::haproxy (
  $vhost,
) {

  concat::fragment { "$title-haproxy":
    target  => "/etc/haproxy/haproxy.cfg", 
    content => template("varnish/_haproxy_include.erb"),
    order   => 50,
  }

  file { "/etc/haproxy/vhosts/$title.cfg":
    content => template("varnish/_haproxy_vhosts.erb"),
    owner   => root,
    group   => root,
  }

}
