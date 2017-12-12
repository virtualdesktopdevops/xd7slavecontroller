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
	dsc_xd7siteconfig{'XD7GlobalSiteSetting':
	 dsc_issingleinstance => 'Yes',
	 dsc_trustrequestssenttothexmlserviceport => true,
	 dsc_psdscrunascredential => {'user' => $svc_username, 'password' => $svc_password}
	}
}