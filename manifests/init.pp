class pe_healthcheck (
  $contact_addresses = 'cbarker@puppetlabs.com',
  $smtp_server       = 'mail.google.com',
) {

  ini_setting { "enable tagmail processor":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => master,
    setting => reports,
    value   => 'http,puppetdb,tagmail',
    ensure  => present,
  }

  ini_setting { "set server mail address":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => master,
    setting => reportfrom,
    value   => "alerts@${fqdn}",
    ensure  => present,
  }

  ini_setting { "set smtp server":
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => master,
    setting => smtpserver,
    value   => "${smtp_server}",
    ensure  => present,
  }

  file_line { 'pe_healhcheck addresses':
    ensure => present,
    line   => "pe_healthcheck: ${contact_addresses}",
    path   => '/etc/puppetlabs/puppet/tagmail.conf',
  }

}
