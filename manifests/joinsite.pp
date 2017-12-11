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
  dsc_script{ 'TrustRequestsToXMLService':
    dsc_getscript => 'Add-PSSnapin -Name Citrix.Broker.Admin.V2 -ErrorAction SilentlyContinue
		$brokersite = Get-BrokerSite
	   Return @{ Result = $brokersite.TrustRequestsSentToTheXmlServicePort) }',
    dsc_testscript => 'Add-PSSnapin -Name Citrix.Broker.Admin.V2 -ErrorAction SilentlyContinue
	   $brokersite = Get-BrokerSite
	   If ($brokersite.TrustRequestsSentToTheXmlServicePort) {
	     Return $true
	   } Else {
       Return $false
	   }',
    dsc_setscript => 'Add-PSSnapin -Name Citrix.Broker.Admin.V2 -ErrorAction SilentlyContinue
	   Set-BrokerSite -TrustRequestsSentToTheXmlServicePort $true',
	dsc_psdscrunascredential => {'user' => $svc_username, 'password' => $svc_password}
  }
	
}