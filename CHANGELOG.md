# CHANGELOG

## 5.0.1

* Drop support of Maven-based install on Ubuntu 14.04
* Refactor testing to use kitchen-dokken (#48)

## 5.0.0

* Upgrade dependencies:
    - `runit` v4.x
    - `maven` v5.x
    - `zookeeper` v10.x
* Use the `zookeeper` cookbook’s version of ZooKeeper
* Drop support for Ubuntu 12.04
* Update CentOS testing & support
* Set an absolute path for `mvn` & `gradle` to fix some CentOS support
* Add SystemD support (#47)

## 4.2.0

* Add defining the mirror (#46)
* Add testing on Ubuntu 16.04

## 4.1.0

* Allow ZooKeeper to be installed to other directories using `node['zookeeper']['install_dir']` attribute

## 4.0.2

* Just updating the CHANGELOG on Supermarket

## 4.0.1

* Remove confusing, unused attributes

## 4.0.0

* Upgrade to `zookeeper ~> 8.0`
* Upgrade other cookbook dependencies to latest as of this writing
* Refactor to use the new custom resources from `zookeeker` 8.x
* Ensure Java 8 is installed for the Maven-based Exhibitor recipes
    - At the moment though, these recipes appear broken

## 3.0.0

* Upgrade to `zookeeper ~> 6.0`
* Fix Vagrant-based CentOS test suites

## 2.0.2

* Fix incorrect usage of `Hash.each` where `Hash.map` should have been used

## 2.0.1

* Fix missed `node[exhibitor][config]` keys in `exhibitor::default`

## 2.0.0

* Refactor to provide two mechanisms to assemble Exhibitor, as per [Netflix’s Exhibitor docs](https://github.com/Netflix/exhibitor/wiki/Building-Exhibitor)
    - This does mean that installing a prebuilt copy of Exhibitor isn’t an option with this version of the cookbook
    - Owing to Maven 3, and just b/c it’s good to keep up-to-date, this cookbook now defaults to Java 7
    - Build/assembly options:
        - Maven (new!)
        - Gradle
* Drop unnecessarily abstracted `Exhibitor::Util` class in favor of more declarative code
* Make use of the `magic` cookbook to avoid reinventing the wheel
* Drop pin for `build-essential` to avoid cross-dependency pain

## 1.0.0

* This version reflects that this cookbook is used in production, and will respect semver moving forward
    - No functional or breaking changes occurred to the cookbook’s code
* Clean up of docs
* Update ownership

## 0.10.0

* Add attribute to use a custom command to run `gradle` (#32, @vanliew)
* Upgrade to `zookeeper ~> 5.0`
    - Brings in potentially breaking change of using `java` cookbook’s `$JAVA_HOME` env var for the version of Java used to run ZooKeeper
* Use `java` cookbook’s `$JAVA_HOME` env var for the version of Java used to run Exhibitor

## 0.9.0

* Bump `zookeeper` to ~> 4.0 (#30 @f1yers)

## 0.8.0

* Add Upstart as an alternative to runit (#29 @davidgiesberg)

## 0.7.1

* Move installation of `node['exhibitor']['patch_package']` to execution phase (#26)
* Drop testing in Chef 11 due to conflict w/ net-ssh gem installed by Serverspec

## 0.7.0

* Add Serverspec tests (#5)
* Bump `zookeeper` to ~> 3.0 (#23)

## 0.6.0

* Add pins to all cookbook dependencies to avoid breaking changes
* Add attribute to control Exhibitor service actions
* Add attribute to set ZooKeeper to be managed by Exhibitor
* Fix Chef overwriting shared config (#20)
* Add `exhibitor::service` to default test suite
* Use Chef Zero for Test Kitchen

## 0.5.0

* Update to Exhibitor 1.5.5 (#18)
    - Includes updates to build script, lifted directly from Exhibitor’s own script
* Fix ownership of downloaded Exhibitor jar (#19)
* Remove duplicate metadata.json file
* Clean up and fix up Test Kitchen config

## 0.4.0

* Just run `install` instead of `default` recipe (contributed by
  @DorianZaccaria)

## 0.3.1

* Fixed bug wherein Exhibitor dearchive reference was incorrect (contributed by
  @benley)

## 0.3.0

* Exhibitor will now explicitly look for dataDir and dataLogDir attributes
  under node[:zookeeper][:config], and prioritize them for calculated values.

## 0.2.1

* Set correct permissions for files Exhibitor needs to run (#7)
* Set correct parameter name for zookeeper-data-directory (#6)

## 0.2.0

* Massive cleanup and minor refactor
* Service now activated in a separate `service` recipe
* Renamed `node[:exhibitor][:defaultconfig]` to `node[:exhibitor][:config]`
* Renamed `node[:exhibitor][:opts]` to `node[:exhibitor][:cli]`
* Added helper library methods
* TODO: Some tests

## 0.1.1

* Cleanup and style fixes. No functional changes.

## 0.1.0

* Initial release of exhibitor, split from zookeeper, contributed by @wolf31o2 
