
create_container = ../../scripts/create_container2

MANPAGEFILES = addserver.man \
               au.man \
               auth2.man \
               authmon.man \
               autobackup.man \
               backup.man \
               bldvldb.man \
               camelot.man \
               clone.man \
               createvol.man \
               createvol_rep.man \
               debug.man \
               deleteuser.man \
               file.man \
               fsck-coda.man \
               gdb.man \
               initpw.man \
               inituser.man \
               installclient.man \
               installserver.man \
               list.man \
               mdd.man \
               merge.man \
               movevol.man \
               nca.man \
               norton.man \
               pcfgen.man \
               purgevol.man \
               purgevol_rep.man \
               pwd2pdb.man \
               readdump.man \
               replay.man \
               salvager.man \
               shutdown-coda.man \
               srv.man \
               startcodav.man \
               startserver.man \
               stats.man \
               updateclnt.man \
               updatemon.man \
               updatesrv.man \
               vdebug.man \
               venus.man \
               vfsck.man \
               vfsvenus.man \
               vol-create.man \
               vol-dump.man \
               vol-purge.man \
               vol-restore.man \
               vol-salvage.man \
               volutil.man \
               vopcon.man \
               vutil.man 

all: $(MANPAGEFILES)

%.sgml.cntr: %.sgml
	  $(create_container) $?

%.man: %.sgml.cntr
	sgml2txt -man $?
	mv $?".man" $@

clean:
	rm -f *.sgml.cntr *.sgml.cntr.man *.man
