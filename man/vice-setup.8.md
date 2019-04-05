% VICE-SETUP(8) Coda Distributed File System

NAME
====

vice-setup - setup a Coda server

SYNOPSIS
========

**Vice-setup**

DESCRIPTION
===========

**Vice-setup** is the user front-end to a family of scripts designed to
setup a Coda server based on question-answer responses. This avoids an
otherwise tedious and error-prone-manual method. The most critical
question asked for the vice-setup family of scripts to work properly is:

    Is this the master server, aka the SCM machine? (y/n) 

Answering \`\`yes\'\' to this question causes the following sequence of
scripts to be called from within **vice-setup**:

**vice-setup-scm**

**vice-setup-user**

**vice-setup-rvm**

**vice-setup-srvdir**

where as answering \`\`no\'\' causes only the following scripts to run
from **vice-setup**:

**vice-setup-rvm**

**vice-setup-srvdir**

OVERVIEW
========

**vice-setup**   

:   is designed to be called directly by the administrator to setup a
    server. It performs the following tasks common to both SCM and non-SCM
    servers:

    Creates the directories, */vice,/vice/{backup,db,srv,vol}* and,
    */vice/vol/remote* if they do not already exist.

    Creates and sets up the authentication files needed for interserver and
    interclient communication.

    Creates and sets up, */vice/db/files*, which are a set of common Coda
    files distributed from the SCM via, **updateclnt**, and **updatesrv**.

    Adds Coda port numbers to, */etc/services* if not already present.

    Sets up the Coda server to start at system startup if so indicated.

    Records the hostname in, */vice/hostname*.

**vice-setup-scm**

    This script is only run if \`\`yes\'\' is given as an answer to the SCM
    question.

    Prompts for a Coda server ID in the range of 0-255, and creates the
    file, */vice/db/servers*, with this information.

    Creates, */vice/db/scm*, with the hostname of the SCM machine being
    setup.

    Creates, */vice/db/VSGDB*, with the root volume number \`\`E0000100\'\'.

    Prompts for the name of the root volume and stores this information in,
    */vice/db/ROOTVOLUME*.

**vice-setup-user**   

:   This script is only run by, **vice-setup**, when the machine is
    designated as the SCM.

    This sets up the System:Administrator group and Coda user \`\`admin\'\'
    then initializes, */vice/db/vice.pdb*.

    Creates, */vice/db/passwd.coda*, needed to setup the initial password
    system.

    Creates, */vice/db/auth.pw*.

**vice-setup-rvm**

:   Prompts for the RVM\_LOG device.

    Prompts for the size of the RVM\_LOG device.

    Prompts for the RVM\_DATA device.

    Prompts for the RVM\_DATA size based on default values. These values
    must be typed exactly right to be accepted. For example, 22M must be
    typed exactly as, \"22M\".

    Initializes the RVM\_LOG and RVM\_DATA devices based on the values given
    for RVM initialization.

    Creates, /vice/srv.conf, with the values given for RVM.

**vice-setup-srvdir**

:   This script sets up the data storage area for a Coda service.

    Prompts for the location a data storage area (default is, /vicepa).

    Creates the empty file, */vicepa/FTREEDB*, which must exist in order
    for, **makeftree**, to function.

    Creates, */vice/db/vicetab*.

    Initializes the data storage area with, **makeftree**.

For a detailed explanation of each question asked by the scripts, please
see the chapter, \`\`Installing a Coda Server\'\' in the Coda Manual.

BUGS
====

Many of the highlights are:

**vice-setup-scm**: does not actually create the ROOTVOLUME it prompts
for. It only sets up the accounting files that point the server(s) to
the root volume. The actual volume must be created after the server is
started for the first time with, **createvol\_rep**.

**vice-setup-rvm**: will not warn you if run a second time after setting
up an otherwise working server. This essentially causes all data stored
on the Coda server in question to be wiped out.

**vice-setup-user**: there is no flexibility in setting up an
administrative user called anything other than \`\`admin\'\'.

**vice-setup-user**: there is a security hole in, **initpw**, that could
allow unauthorized Coda \`\`admin\'\' access and/or denial of service if
an unauthorized user gains root access to the SCM.

**vice-setup-user**: a user \`\`admin\'\' with a uid of 500 must exist
on each client that needs to have admin access to Coda. There is no
practical way to test for this. The hardcoding of uid 500 may cause
additional trouble at some sites.

**vice-setup-rvm**: will add entries to, */vice/srv.conf*, each time it
is run without removing the previous contents. If more than one line of
server information is present in, *srv.conf*, a \`\`multiple instance
error\'\' is returned by, **srv**, because multiple lines in,
*srv.conf*, are treated as a single set of command line arguments to
**srv**. Essentially, the resulting error is made sufficiently out of
context and is difficult to detect.

**vice-setup**: does not determine the host IP address.

Error messages returned by the scripts or the programs called from
within the scripts do not jump out and bark at you. Instead, errors are
easily missed while running the scripts and these errors tend to come
back and bite you later.

If a non-SCM server is being setup, you still must respond with tokens
to, **vice-setup**, when asked. However, the response must be identical
to the SCM or the ticket files must be copied from the SCM manually for
interserver communication to work correctly.

**auth2**, **updateclnt** and **updatesrv** must be started manually on
a non-SCM to suck down the real versions of these files from the actual
SCM. This error in logic can be misleading.

On non-SCM Servers, the following files on the SCM must be edited or
copied from the SCM manually before running **vice-setup**:
*/vice/db/services* */vice/db/hosts* to complete the setup of a non-SCM
server.

FILES
=====

*/vice/db/vicetab*

:   the Vice Table Configuration file for srv.

*/vice/vol/VolumeList*

:   volumeList of the server.

*/vice/db/scm*

:   the SCM hostname.

*/vice/hostname*

:   the host\'s hostname.

*/vice/srv.conf*

:   the **srv** configuration file.

*/vice/db/services* */vice/db/ROOTVOLUME* */vice/db/VSGDB* */vice/db/vice.pfc* */vice/db/vice.pdb*

:   And many more files are touched by these scripts than are listed here.

SEE ALSO
========

**srv**(8), **rvmutl**(8), **rdsinit**(8), **auth2**(8), **authmom**(8), **updatemon**(8),
**updatesrv**(8), **updateclnt**(8), **startserver**(8), **srv.conf**(8),
**createvol\_rep**(8), **pwd2pdb**(8), **initpw**(8), **makeftree**(8), **vicetab**(5)

Coda Manual: \`\`Installing A Coda Server\'\' The RVM Manual

AUTHOR
======

Henry M.\ Pierce, 1998, created
