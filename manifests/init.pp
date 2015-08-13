# == Class: varnish
#

class varnish (
  $version           = $::varnish::params::version,
  $varnish_ip        = $::varnish::params::listen_ip,
  $varnish_port      = $::varnish::params::varnish_port,
  $admin_ip          = $::varnish::params::admin_ip,
  $admin_port        = $::varnish::params::admin_port,
  $nfiles            = $::varnish::params::nfiles,
  $memlock           = $::varnish::params::memlock,
  $nprocs            = $::varnish::params::nprocs,
  $reload_vcl        = $::varnish::params::reload_vcl,
  $secret_file       = $::varnish::params::secret_file,
  $min_threads       = $::varnish::params::min_threads,
  $max_threads       = $::varnish::params::max_threads,
  $thread_timeout    = $::varnish::params::thread_timeout,
  $storage_size      = $::varnish::params::storage_size,
  $storage_type      = $::varnish::params::storage_type,
  $daemon_user       = $::varnish::params::daemon_user,
  $daemon_group      = $::varnish::params::daemon_group,

) inherits ::varnish::params {

  package { "varnish":
    ensure => $version,
  }

  service { "varnishd":
    ensure => "running",
  }

  package { "haproxy":
    ensure => "latest",
  }

  service { "haproxy":
    ensure => "running",
  }

  file { "/etc/varnish/main.vcl":
    content => template("varnish/main.vcl.erb"),
    owner   => varnish,
    group   => varnish,
  }

  file { "/etc/haproxy/vhosts":
    ensure => "directory",
    owner  => root,
    group  => root,
  }

  concat { "/etc/haproxy/haproxy.cfg":
    owner => root,
    group => root,
  }

  concat::fragment { "haproxy":
    target  => "/etc/haproxy/haproxy.cfg",
    content => template("varnish/_haproxy.erb"),
    order   => 1,
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

  varnish::sysconfig { "sysconfig":
    varnish_ip     => $varnish_ip,
    varnish_port   => $varnish_port,
    admin_ip       => $admin_port,
    admin_port     => $admin_port,
    nfiles         => $nfiles,
    memlock        => $memlock,
    nprocs         => $nprocs,
    reload_vcl     => $reload_vcl,
    secret_file    => $secret_file,
    min_threads    => $min_threads,
    max_threads    => $max_threads,
    thread_timeout => $thread_timeout,
    storage_size   => $storage_size,
    storage_type   => $storage_type,
    daemon_user    => $daemon_user,
    daemon_group   => $daemon_group,
  }

}

