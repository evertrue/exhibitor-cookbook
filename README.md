# Exhibitor
Chef cookbook for installing and managing Netflix's
[Exhibitor](https://github.com/Netflix/exhibitor), a co-process for Apache
Zookeeper.

## Usage
In particular, two key attribute hashes drive this cookbook.

The first is `node['exhibitor']['cli']`, which specifies command-line options
that will be used when Exhibitor is run. Some are necessary, and in particular
the defaults provided will ensure Exhibitor is able to run.

The second is `node['exhibitor']['config']`, which manages the configuration
parameters that get rendered to the `exhibitor.properties` file. The defaults
are sane starting values.

We recommend running `exhibitor::default` to get a basic, default setup of
Exhibitor going, as well as calling `exhibitor::service` if you want the
service to boot up in the same run. These recipes are split for workflows
within, for example, AMI pipelines.

More documentation to come. Please see the [Exhibitor
docs](https://github.com/Netflix/exhibitor/wiki) for more
information on the specifics of running Exhibitor.

## Author and License 
Simple Finance <ops@simple.com>

Apache License, Version 2.0
