# Class: xd7slavecontroller
#
# This module manages xd7slavecontroller
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class xd7slavecontroller (
  $svc_username,
  $svc_password,
  $sourcepath,
  $sitename,
  $site_mastercontroller,
  $https = false,
  $sslCertificateSourcePath = '',
  $sslCertificatePassword = '',
  $sslCertificateThumbprint = ''
)

{
  #include puppetlabs-dsc
  contain xd7slavecontroller::install
  contain xd7slavecontroller::joinsite
  contain xd7slavecontroller::sslconfig
  Class['::xd7slavecontroller::install'] ->
  Class['::xd7slavecontroller::joinsite'] ->
  Class['::xd7slavecontroller::sslconfig']
  
  reboot { 'dsc_reboot':
	 when    => pending
  }
}

