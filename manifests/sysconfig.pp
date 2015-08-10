define varnish::sysconfig (
  varnish_ip,
  varnish_port,
  admin_ip,
  admin_port,
  nfiles,
  memlock,
  nprocs,
  reload_vcl,
  secret_file,
  min_threads,
  max_threads,
  thread_timeout,
  storage_size,
  storage_type,
  daemon_user,
  daemon_group,
) {

  file { "/etc/sysconfig/varnish":
    content => template("varnish/sysconfig.erb"),
    owner   => root,
    group   => root,
  }

}


