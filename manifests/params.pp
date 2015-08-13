#
# Class Params:
#

class varnish::params {

  $version            = "4.0.3-1.el6"
  $varnish_ip         = $::ipaddress
  $varnish_port       = "80"
  $admin_ip           = $::ipaddress_lo
  $admin_port         = "6030"
  $nfiles             = "131072"
  $memlock            = "82000"
  $nprocs             = "unlimited"
  $reload_vcl         = "-1"
  $secret_file        = "/etc/varnish/secret"
  $min_threads        = $::processorcount * 5
  $max_threads        = $::processorcount * 700
  $thread_timeout     = "120"
  
  if $::memorysize_mb > 10 {
    $storage_type = "malloc"
    $storage_size = $::memorysize_mb / 2
  } else { 
    $storage_type = "file"
    $storage_size = $::partitions["sda2"]["size"] / 2
  }

  $daemon_user        = "varnish"
  $daemon_group       = "varnish"

}
