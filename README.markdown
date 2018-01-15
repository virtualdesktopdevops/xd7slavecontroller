# xd7slavecontroller #

This modules install a fully working Citrix 7.x Delivery Controller and registers it to an existing XenApp/XenDesktop 7.x site. All the site configuration and database access setup is grabbed from the existing controller.

The following options are available for a production-grade installation :
- Sécurity : SSL configuration to secure communications with the Citrix XML service

## Integration informations
The SSL certificate provided needs to be a password protected p12/pfx certificate including the private key.

The module can be installed on a Standard, Datacenter version of Windows 2012R2 or Windows 2016. **Core version is not supported by Citrix for delivery Controller installation**.

Migrated puppet example code in README.md to future parser syntax (4.x). Impact on parameters refering to remote locations (file shares) which have to be prefixed with \\\\ instead of the classical \\. This is because of Puppet >= 4.x parsing \\ as a single \ in single-quoted strings. Use parser = future in puppet 3.x /etc/puppet/puppet.conf to use this new configuration in your Puppet 3.x and prepare Puppet 4.x migration.

## Usage
- **svc_username** : (string) Privileged account used by Puppet to join the controller to the existing Xendesktop Site (Citrix administrator privilèges needed)
- **svc_password** : (string) Password of the privileged account. Should be encrypted with hiera-eyaml.
- **sourcepath** : (string) Path of a folder containing the Xendesktop 7.x installer (unarchive the ISO image in this folder). Has to be prefixed with \\\\ instead of the classical \\ if using UNC Path and Puppet >= 4.x or Puppet 3.x future parser.
- **sitename** : (string) Name of the existing Xendesktop site
- **site_mastercontroller** : (string) FQDN of one of the controllers of the existing Xendesktop 7. This controller will be contacted by puppet to join the current controller
- **https** : (boolean) : true or false. Deploy SSL certificate and activate SSL access to Citrix XML service ? Default : false
- **sslCertificateSourcePath** : (string) Location of the SSL certificate (p12 / PFX format with private key). Can be local folder, UNC path, HTTP URL). Has to be prefixed with \\\\ instead of the classical \\ if using UNC Path and Puppet >= 4.x or Puppet 3.x future parser.
- **sslCertificatePassword** : (string) Password protecting the p12/pfx SSL certificate file.
- **sslCertificateThumbprint** : (string) Thumbprint of the SSL certificate (available in the SSL certificate).

## Installing a Citrix Delivery Controller

~~~puppet
node 'CXDC' {
	class{'xd7slavecontroller':
	  svc_username => 'TESTLAB\svc-puppet',
	  svc_password => 'P@ssw0rd',
	  sitename => 'XD7TestSite',
	  site_mastercontroller => 'srv-cxdc01',
	  sourcepath => '\\\\fileserver\xendesktop715',
	  https => true,
	  sslCertificateSourcePath => '\\\\fileserver\ssl\cxdc.pfx',
	  sslCertificatePassword => 'P@ssw0rd',
	  sslCertificateThumbprint => '44cce73845feef4da4d369a37386c862eb3bd4e1'  
	}
}
~~~
