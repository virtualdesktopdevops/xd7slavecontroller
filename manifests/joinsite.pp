class xd7slavecontroller::joinsite inherits xd7slavecontroller {
  
  dsc_xd7waitforsite{ 'WaitForXD7Site':
  dsc_sitename => $sitename,
  dsc_existingcontrollername => $site_mastercontroller,
  dsc_credential => {'user' => $svc_username, 'password' => $svc_password} 
  }->

	dsc_xd7controller{ 'XD7ControllerJoin':
	  dsc_sitename => $sitename,
	  dsc_existingcontrollername => $site_mastercontroller,
	  dsc_credential => {'user' => $svc_username, 'password' => $svc_password} 
	}->
	
  #Trust request sent to XML service
  dsc_script{ 'CitrixBrokerServiceSSL':
    dsc_getscript => 'Add-PSSnapin Citrix*
     Return @{ Result = [bool]$(Get-BrokerSite | fl TrustRequestsSentToTheXmlServicePort) }',
    dsc_testscript => 'Add-PSSnapin Citrix*
     If (Get-BrokerSite | fl TrustRequestsSentToTheXmlServicePort) {
       Return $true
     } Else {
       Return $false
     }',
    dsc_setscript => 'Add-PSSnapin Citrix*
     Set-BrokerSite -TrustRequestsSentToTheXmlServicePort $true'
  }
	
}