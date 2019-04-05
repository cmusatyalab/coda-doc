% VOLMUNGE(8) Coda Distributed File System

NAME
====

volmunge - manipulates objects within Coda

SYNOPSIS
========

**volmunge** \<-adfmov\> dir

**-a**

:   Prints out everything but does not cross volume boundaries.

**-d**

:   Prints out UNIX directories, but not volume mount points.

**-f**

:   Prints out all objects which are not volume mount points (eg UNIX files
    and UNIX directories); this preforms a stat() call on all non-volume
    objects which is ideal for forcing resolution on a volume.

**-m**

:   Prints out those objects which are volume mount points.

**-o**

:   Prints out those objects which are UNIX files and preforms an open()
    call on the file.

**-v**

:   Prints out the volume name of a volume\'s mount point.

DESCRIPTION
===========

**volmunge**: is ideal for identifying Coda objects versus regular UNIX
files (including UNIX directories) stored within the Coda filesystem. It
will work recursively. Because the, **-f** and **-o**, call the stat(),
and open() functions respectively, resolution many be forced with
volmunge if one is reconstituting a replicated Coda volume or group of
volumes mounted on top of each other.

SEE ALSO
========

**find**(1), **perl**(1)

AUTHOR
======

Henry M.\ Pierce, 1998, created
