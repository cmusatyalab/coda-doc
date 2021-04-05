% VOLMUNGE(1) Coda Distributed File System

NAME
====

volmunge - manipulates objects within Coda

SYNOPSIS
========

**volmunge** \<-adflmuioqvx\> dir

**-a**

:   Prints out everything.

**-d**

:   Prints out UNIX directories, but not volume mount points.

**-f**

:   Prints out all objects which are not volume mount points (eg UNIX files
    and symlinks); this performs a stat() call on all non-volume objects
    which is ideal for forcing resolution on a volume.

**-m**

:   Prints out those objects which are volume mount points.

**-u**

:   Prints out those objects which are unmounted volume mount points (mount-links).

**-i**

:   Prints out those objects which indicate there is an unrepaired conflict (inconsistent object).

**-o**

:   Perform and open() call on all UNIX files, forces a fetch into local Coda cache.

**-q**

:   Be less verbose.

**-v**

:   Be more verbose.

**-x**

:   Cross volume boundaries.

DESCRIPTION
===========

**volmunge**: is ideal for identifying Coda objects versus regular UNIX
files (including UNIX directories) stored within the Coda filesystem. It
will work recursively.

Because the **-f** and **-o** explicitly call the stat()
and open() functions respectively, resolution can be forced with
volmunge if one is rebuilding a replicated Coda volume or group of
volumes mounted on top of each other.

However, it is expected that stat() will be called on all objects either way
because Coda does not provide directory vs. file information in the readdir()
result so any type of volume traversal should trigger automatic resolution.

SEE ALSO
========

**find**(1)

AUTHOR
======

Henry M.\ Pierce, 1998, created.

Jan Harkes, 2021, rewritten in Python.
