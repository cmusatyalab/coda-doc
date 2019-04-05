% STARTSERVER(8) Coda Distributed File System

NAME
====

startserver - Start the CFS file server

SYNOPSIS
========

**startserver**

DESCRIPTION
===========

**startserver** is used to start the CFS file server process. It will
clean up old log files, then start the server. This script is useful for
starting the server with the same configuration every time its run.

FILES
=====

*codasrv* */vice/srv/SrvErr* */vice/srv/SrvLog\* * */vice/srv/srv.conf*

SEE ALSO
========

**codasrv**(8)

AUTHOR
======

Joshua Raiff, 1993, Created man page
