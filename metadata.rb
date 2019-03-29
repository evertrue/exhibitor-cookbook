name             'exhibitor'
maintainer       'EverTrue'
maintainer_email 'devops@evertrue.com'
license          'Apache-2.0'
description      'Installs Netflix Exhibitor'
version          '5.0.2'
chef_version     '>= 12.5' if respond_to?(:chef_version)

issues_url 'https://github.com/evertrue/exhibitor-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/evertrue/exhibitor-cookbook/' if respond_to?(:source_url)

supports 'ubuntu', '>= 14.04'
supports 'centos', '>= 6.0'

depends          'build-essential'
depends          'java', '~> 1.35'
depends          'runit', '~> 4.0'
depends          'zookeeper', '~> 10.0'
depends          'magic', '~> 1.5'
depends          'et_gradle', '~> 2.0'
depends          'maven', '~> 5.0'
