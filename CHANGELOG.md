# CHANGELOG

## Unreleased

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
