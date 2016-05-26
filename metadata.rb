name             'exhibitor'
maintainer       'EverTrue'
maintainer_email 'devops@evertrue.com'
license          'Apache v2.0'
description      'Installs Netflix Exhibitor'
version          '0.10.0'

issues_url 'https://github.com/evertrue/exhibitor-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/evertrue/exhibitor-cookbook/' if respond_to?(:source_url)

depends          'build-essential', '~> 2.2'
depends          'java', '~> 1.35'
depends          'runit', '~> 1.7'
depends          'zookeeper', '~> 5.0'
