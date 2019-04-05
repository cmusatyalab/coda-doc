% CUNLOG(1) Coda Distributed File System
%
% 25 April 2005

NAME
====

cunlog - Tell the Coda client to release authentication tokens

SYNOPSIS
========

**cunlog** \[ **\@realm** \]

DESCRIPTION
===========

This command enables a user to inform the Coda Cache Manager, **venus**,
to release the authentication tokens for that user. Without these
tokens, the user will not be able to access or modify his or her
protected files until he or she re-authenticates by running **clog**.

SEE ALSO
========

**clog**(1), **ctokens**(1)

AUTHORS
=======

* 1987, Adapted from AFS-2s unlog

* David Steere, 1990, Created man page
