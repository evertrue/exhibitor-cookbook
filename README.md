# Exhibitor
Chef cookbook for installing and managing Netflix's
[Exhibitor](https://github.com/Netflix/exhibitor), a co-process for Apache
Zookeeper.

## Usage
TODO.

### Attributes
To override exhibitor command line options, add them to
`node[:exhibitor][:opts]`. See [Running
Exhibitor](https://github.com/Netflix/exhibitor/wiki/Running-Exhibitor) for
more details.

The `node[:exhibitor][:config]` attribute contains config that exhibitor will
be initialized with.  See the Exhibitor [Configuration
UI](https://github.com/Netflix/exhibitor/wiki/Configuration-UI) and [Running
Exhibitor](https://github.com/Netflix/exhibitor/wiki/Running-Exhibitor) docs
for more information.

## Author and License Simple Finance <ops@simple.com>

Apache License, Version 2.0
