class xd7slavecontroller::install inherits xd7slavecontroller {
  reboot { 'after_run':
    apply => finished,
  } 
  
   dsc_xcredssp{ 'Server':
      dsc_ensure => 'Present',
      dsc_role => 'Server',
      notify => Reboot['after_run']
  }

  dsc_xcredssp{ 'Client':
      dsc_ensure => 'Present',
      dsc_role => 'Client',
      dsc_delegatecomputers => '*'
  }
  
  #Ensure IIS is not installed on the system to avoid conflicts with Broker Service
  dsc_windowsfeature{'iis':
	  dsc_ensure => 'Absent',
	  dsc_name   => 'Web-Server',
	}
  
  #Install Delivery Controller
  dsc_xd7features { 'XD7DeliveryController':
    dsc_issingleinstance => 'Yes',
    dsc_role => [Studio, Controller],
    dsc_sourcepath => $sourcepath,
    dsc_ensure => 'present',
	require => Dsc_windowsfeature['iis'],
	notify => Reboot['after_run']
  }
}