Team and repository tags
========================

[![Team and repository tags](https://governance.openstack.org/tc/badges/puppet-ec2api.svg)](https://governance.openstack.org/tc/reference/tags/index.html)

<!-- Change things from this point on -->

ec2api
=======

#### Table of Contents

1. [Overview - What is the ec2api module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with ec2api](#setup)
4. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - Those with commits](#contributors)

Overview
--------

The ec2api module is a part of [OpenStack](https://opendev.org/openstack), an effort by the OpenStack infrastructure team to provide continuous integration testing and code review for OpenStack and OpenStack community projects not part of the core software.  The module its self is used to flexibly configure and manage the EC2 API service for OpenStack.

Module Description
------------------

The ec2api module is a thorough attempt to make Puppet capable of managing the entirety of ec2api.  This includes manifests to provision region specific endpoint and database connections.  Types are shipped as part of the ec2api module to assist in manipulation of configuration files.

Setup
-----

**What the ec2api module affects**

* [Ec2api](https://docs.openstack.org/ec-2api/latest/), the EC2 API service for OpenStack.

### Installing ec2api

    ec2api is not currently in Puppet Forge, but is anticipated to be added soon.  Once that happens, you'll be able to install ec2api with:
    puppet module install openstack/ec2api

### Beginning with ec2api

To utilize the ec2api module's functionality you will need to declare multiple resources.

Implementation
--------------

### ec2api

ec2api is a combination of Puppet manifest and ruby code to delivery configuration and extra functionality through types and providers.

Limitations
------------

* All the ec2api types use the CLI tools and so need to be ran on the ec2api node.

Development
-----------

Developer documentation for the entire puppet-openstack project.

* https://docs.openstack.org/puppet-openstack-guide/latest/

Contributors
------------

* https://github.com/openstack/puppet-ec2api/graphs/contributors

Release Notes
-------------

* https://docs.openstack.org/releasenotes/puppet-ec2api

Repository
----------

* https://opendev.org/openstack/puppet-ec2api


