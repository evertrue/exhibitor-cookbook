name             'exhibitor'
maintainer       'EverTrue'
maintainer_email 'devops@evertrue.com'
license          'Apache v2.0'
description      'Installs Netflix Exhibitor'
version          '2.0.2'

issues_url 'https://github.com/evertrue/exhibitor-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/evertrue/exhibitor-cookbook/' if respond_to?(:source_url)

depends          'build-essential'
depends          'java', '~> 1.35'
depends          'runit', '~> 1.7'
depends          'zookeeper', '~> 6.0'
depends          'magic', '~> 1.5'
depends          'et_gradle', '~> 2.0'
depends          'maven', '~> 2.2'
