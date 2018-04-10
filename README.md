# Exhibitor

[![Build Status](https://travis-ci.org/evertrue/exhibitor-cookbook.svg?branch=master)](https://travis-ci.org/evertrue/exhibitor-cookbook)
[![Chef cookbook](https://img.shields.io/cookbook/v/exhibitor.svg)](https://supermarket.chef.io/cookbooks/exhibitor)

Chef cookbook for installing and managing Netflix's
[Exhibitor](https://github.com/Netflix/exhibitor), a co-process for Apache
Zookeeper.

## Caveats

Attempting to install Exhibitor, using Maven, on Ubuntu 14.04, will result in an error:

```
[ERROR] Plugin org.apache.maven.plugins:maven-clean-plugin:2.5 or one of its dependencies could not be resolved: Failed to read artifact descriptor for org.apache.maven.plugins:maven-clean-plugin:jar:2.5: Could not transfer artifact org.apache.maven.plugins:maven-clean-plugin:pom:2.5 from/to central (https://repo.maven.apache.org/maven2): java.lang.RuntimeException: Unexpected error: java.security.InvalidAlgorithmParameterException: the trustAnchors parameter must be non-empty -> [Help 1]
```

As a result, we do not support this.

## Usage

In particular, two key attribute hashes drive this cookbook.

The first is `node['exhibitor']['cli']`, which specifies command-line options
that will be used when Exhibitor is run. Some are necessary, and in particular
the defaults provided will ensure Exhibitor is able to run.

The second is `node['exhibitor']['config']`, which manages the configuration
parameters that get rendered to the `exhibitor.properties` file. The defaults
are sensible starting values.

We recommend running `exhibitor::default` to get a basic, default setup of
Exhibitor going, as well as calling `exhibitor::service` if you want the
service to boot up in the same run. These recipes are split for workflows
within, for example, AMI pipelines.

More documentation to come. Please see the [Exhibitor
docs](https://github.com/Netflix/exhibitor/wiki) for more
information on the specifics of running Exhibitor.

## Author and License 

EverTrue <devops@evertrue.com>  
Simple Finance <ops@simple.com>

Apache License, Version 2.0
