# mapr-core-bash-completion

Provide bash (Bourne Again Shell) autocompletion for MapR commands

## Branch information

HPE maintains multiple releases of the Ezmeral Data Fabric, previously
branded MapR.  For this reason it is important to match the release of
your MapR installation to the release of the bash completion.

Mismatched versions of the autocompletion will offer different options
in command line calls than the command line actually supports.  When
using a packaged version of the mapr-core-bash-completion, the package
and packaging system attempt to ensure a matching version is installed;
however, there are a number of installation approaches that avoid the
assurance of a matching version; and, system administrators can
override the packaging system's version management.

If you feel that a completion is incorrect, first check the version
of MapR by running one of the following commands.

For RPM based systems:

    rpm --query mapr-core

For Debian based systems:

    dpkg --list mapr-core

The first three numbers are the MapR version.  Compare that number
to the output of the mapr-core-bash-completion package.

For RPM based systems:

    rpm --query --file /usr/share/bash-completion/completions/maprcli

For Debian based systems:

    dpkg --search /usr/share/bash-completion/completions/maprcli

If a package name is returned, the first three digits of the package
will be the version that the installed mapr-core-bash-completion
package is meant to support.

If no package name is returned, then the installation was not
preformed by the package manager.  To inspect the version of the
file, run the command:

For checking the internal file version:

    head -4 /usr/share/bash-completion/completions/maprcli

And search for the supported MapR version number in the returned text.

## License information and authors

mapr-core-bash-completion is available under the terms of the Apache
Public License (version 2.0).

Contributors to this verson of mapr-core-bash-completion are:

* Edwin Buck

## Installation/removal

### Package manager local installation

The simplest installation method is to download a version of the RPM or
DEB that matches your package manager, and to install the software
using your system's package manager.

For RPM based systems:

    rpm --install ./mapr-core-bash-completion-<version>.rpm

For Deb based systems:

    dpkg --install ./mapr-core-bash-completion-<version>.deb

### Package manager remote installation

Many package managers use additional utilities to obtain packages from
one or more repositories prior to installation.  If your enviornment
contains a package repository for 3rd party software, please download
the copies of the packages required to support your envionment and
have your repository maintainer add them to your package repository.

Once installed in your package repository, a properly configured system
using that repository will install the package without prior copying
of the package directly to the system.  To install the software, use
one of the following approaches.

For YUM based systems:

    yum install mapr-core-bash-completion

For DNF based systems:

    dnf install mapr-core-bash-completion

For APT-GET based systems:

    apt-get install mapr-core-bash-completion

If many versions are maintained one might need to consult their tool's
specific options to ensure the correct version is sourced and installed.

## How to use

Pressing the tab key once will expand a partially typed item.  If an item
has only one possible expansion, the partially typed item will expand
to match the only possible expansion.  If an item has more than one
possible expansion, the partially typed item will expand to include the
common letters or symbols of the matching items.  This might not expand
a partially typed item to a fully useable option when two or more items
have differences in letters near the end of those items.  Occasionally
no expansion will take place, when all of the items that could be typed
share no common prefixes.

Pressing the tab key twice in rapid succession will display all of the
partially matching items, permitting one to select between the remaining
viable options.  In the event that a partial item has no viable
expansions, no items will be returned.

## Changelog

** mapr-core-bash-completion **

* *2023-01-06* Add README.md
