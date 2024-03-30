# File: nginx_setup.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx for 301 redirect
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => template('nginx/default.conf.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Create index.html with 'Hello World!' content
file { '/var/www/html/index.html':
  content => 'Hello World!',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
