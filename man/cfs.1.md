% CFS(1) Coda Distributed File System
%
% 25 April 2005

NAME
====

cfs - Coda File System Interface Program

SYNOPSIS
========

**cfs adaptive\|strong**

**cfs beginrepair** *file*

**cfs checkpointml**

**cfs checkservers**

**cfs checkvolumes**

**cfs clearpriorities**

**cfs \@cpu\|\@sys**

**cfs endrepair** *file*

**cfs examineclosure**

**cfs flushcache**

**cfs flushobject** *path* \[ *path \...* \]

**cfs flushvolume** *path* \[ *path \...* \]

**cfs getfid** *path* \[ *path \...* \]

**cfs getpath** *fid* \[ *fid \...* \]

**cfs getmountpoint** *volid*

**cfs listacl** *dir* \[ *dir \...* \]

**cfs listcache** *dir* \[ *dir \...* \]

**cfs listvol** *dir* \[ *dir \...* \]

**cfs lsmount** *dir* \[ *dir \...* \]

**cfs mkmount** *directory* \[ *volumename* \]

**cfs purgeml**

**cfs replayclosure**

**cfs rmmount** *dir* \[ *dir \...* \]

**cfs setacl** \[ **-clear** \] \[ **-negative** \] *dir* *id* *rights*
\[ *id*** ***rights \...* \]

**cfs truncatelog**

**cfs waitforever** \[ **-on** \] \[ **-off** \]

**cfs whereis** *dir* \[ *dir \...* \]

**cfs disconnect**

**cfs reconnect**

**cfs writedisconnect** \[ **-age ***secs* \] \[ **-time ***secs* \]
*dir*

**cfs writereconnect**

DESCRIPTION
===========

**cfs** allows users to perform operations specific to the Coda File
System. Most often, people use it to see how much of their allocated
storage space they are currently using and to change the protection on
their personal directories. **cfs** will change the protection or
\"rights\" on directories but not on individual files. To change
permissions on individual files, use **chmod**(1).

**adaptive\|strong**

:   Use \`strong\' to override adaptation to changing network
    conditions. Revert to automatic adaptation using \`adaptive\'. This
    command is useful to force strong connectivity semantics even over
    slow or unreliable links.

**checkpointml**

:   Checkpoint volume modify log. This command will create a checkpoint
    file /usr/coda/spool/uid/vol\@mountpt. Where uid is your local user
    id, vol is the volume being checkpointed, and mountpt is the
    volume\'s mount point.

    Abbreviation: **ck**.

**checkservers**

:   Check the status of the Coda file servers. Report on servers that
    are down.

**checkvolumes**

:   Check volume/name mappings.

**clearpriorities**

:   Clear short-term priorities used for cache management.

**\@cpu\|\@sys**

:   When the end of a pathname component in a symlink is either \@sys or
    \@cpu, the local venus will replace these magic strings with a
    platform dependent string. These cfs commands can be used to check
    what the precise expansion values depending on the current OS/cpu.

**beginrepair**

:   Tell venus to expand a conflict. The dangling symlink becomes a
    directory that contains readonly copies of all the versions of the
    object as found on the various replicas.

    Abbreviation: **br**.

**endrepair**

:   Tell venus to end a repair session on file. Useful if repair is
    exits without finishing the repair session.

    Abbreviation: **er**.

**examineclosure**

:   Examine reintegration closure. Using **cfs** **examineclosure** will
    display the fixfile used to reintegrate changes that were made while
    operating in disconnected mode.

    Abbreviation: **ec**

**flushcache**

:   Flush entire cache. Care must be taken when using the **cfs**
    **flushcache** command, as flushing the cache while operating in
    disconnected mode may result in loss of data.

**flushobject**

:   Flush objects from cache. **cfs** **flushobject** tells venus to
    remove the given objects from the cache.

    Abbreviation: **fl**

**flushvolume**

:   Flush all data in specified volumes. Care must be taken when using
    the **cfs** **flushvolume** command, as flushing the cache while
    operating in disconnected mode may result in loss of data.

**getfid**

:   Map the given paths to Coda file ids.

    Abbreviation: **gf**

**getpath**

:   Map fid to volume-relative path. **cfs** **getpath** will display
    the path for each of the given fids.

    Abbreviation: **gp**

**listacl**

:   List access control list for each of the given directories.

    Abbreviation: **la**

**listcache**

:   List the contents of the entire cache or the given volumes
    (directories).

    Abbreviation: **lc**

**listvol**

:   Display the current status of the volume in which the directory is
    stored.

    Abbreviation: **lv**

**lsmount**

:   List the countents of a mount point. This command can be used to
    tell what volume a mount point refers to.

**mkmount**

:   Create a mount point. Mount **volume name** at the point in the file
    system described by **filename**. If the **volume name** is not
    specified, venus will try to mount a volume named based on the path
    from the top of the realm to the mountpoint. For instance, **cfs
    mkmount /coda/coda.cs.cmu.edu/new** will attempt to mount a volume
    named **/new**.

    Abbreviation: **mkm**

**purgeml**

:   Purge volume modify log. Care must be taken when using the **cfs**
    **purgeml** command, as it may result in loss of data.

**replayclosure**

:   Replay reintegration closure.

    Abbreviation: **rc**

**rmmount**

:   Remove a mount point from the file system. The volume itself is not
    changed.

    Abbreviation: **rmm**

**setacl**

:   Set access control list. Sets the access control list for each
    **id**. The **-clear** switch clears the access control list except
    for the entries given on the call to **cfs**. The **-negative**
    switch denies the given permissions, rather than granting them.
    **Rights** are a subset of **rwidlak** which are read, write,
    insert, delete, lookup, administer, and lock respectively. See the
    section on **File Protection** in the *Coda File* System Users and
    System Administrators Manual for more detail.

    Abbreviation: **sa**

**truncatelog**

:   Truncate the RVM log at this instant.

    Abbreviation: **tl**

**waitforever**

:   Tells venus whether it should wait forever for dead file servers or
    not. By default, venus does not wait; it returns ETIMEDOUT. For
    certain batch jobs, waiting is better than not waiting.

    Abbreviation: **wf**

**whereis**

:   List the servers that the given files reside on.

**disconnect**

:   Partition your client from the Coda file servers.

**reconnect**

:   Reconnect to the Coda file servers. **cfs** **reconnect** will undo
    the effects of a **cfs** **disconnect**.

**writedisconnect**

:   Tell venus to write disconnect on the given volumes, or all volumes
    if none are provided. Write disconnected operation will fetch files
    from the server, but does not propagate changes back immediately.

    An **-age** argument gives the age of the CML before it should be
    reintegrated. The **-time** arguments gives the number of seconds the
    sending of a reintegration fragment should take.

    Abbreviation: **wd**

**writereconnect**

:   Strongly connect to the servers.

    Abbreviation: **wr**

SEE ALSO
========

**chmod**(1)

AUTHORS
=======

* 1987, Adapted from AFS-2s fs
* Maria R.\ Ebling, 1990, Created man page
* M.\ Satyanarayanan, 1992, cfs rewritten from scratch
* Joshua Raiff, 1993, Man page rewritten
* Joshua Raiff, 1995, Updated
