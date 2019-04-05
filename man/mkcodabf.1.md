% MKCODABF(1) Coda Distributed File System
%
% 11 August 2006

NAME
====

mkcodabf - Make a \'big file\' directory tree for Coda

SYNOPSIS
========

**mkcodabf** \[**-f ***files-per-dir*\] \[**-s ***hunk-size*\]
\[**-v**\] *file* *new-dir*

DESCRIPTION
===========

**mkcodabf** will take an existing large *file* and produce a directory
tree rooted at *new-dir* of much smaller files, called hunks. Each hunk,
except the last hunk, will be an integral number of megabytes as
controlled by the **-s** flag. The number of hunk files and
subdirectories in each directory is controlled by the **-f** flag. Also,
in the directory *new-dir*, a meta-data file, named *\_Coda\_BigFile\_*,
will be created so that *new-dir* will appear as a large, read only,
regular file after being written to the Coda Distributed File System.

The reason for these \'big files\' is to allow one to write a very large
file, one that is larger than the *venus cache*, to Coda and to be able
to read it back. These are primarily expected to be some kind of media
files which are written once and read many times, often in a sequential
fashion by a media player. For this reason, *file* is expected to not be
stored in the Coda file tree and *new-dir* is expected to be in the Coda
file tree.

**mkcodabf** supports the following options:

**-f files-per-dir**

:   The number of hunk files or subdirectories in each directory in the
    \'big file\' directory tree. The default number is 100 entries per
    directory.

**-s hunk-size**

:   The size of each hunk file in megabytes. The default hunk size is
    one megabyte.

**-v**

:   Print verbose output as each directory and file is created. The
    default is to quietly create the directory tree.

BUGS
====

* Currently, only the kernel module for Windows supports \'Big Files\'.

AUTHORS
=======

Philip A.\ Nelson, August 2006
