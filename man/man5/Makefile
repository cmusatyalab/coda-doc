
create_container = ../../scripts/create_container2

MANPAGEFILES = backup.man \
 	       dumpfile.man \
 	       dumplist.man \
	       passwd_coda.man \
 	       groups_coda.man \
 	       maxgroupid.man \
 	       multicastagents.man \
 	       multicastgroups.man \
 	       servers.man \
 	       user_coda.man \
 	       volumelist.man \
 	       vrdb.man \
 	       vrlist.man \
 	       vsgdb.man \
 	       vstab.man 

all: $(MANPAGEFILES)

%.sgml.cntr: %.sgml
	  $(create_container) $?

%.man: %.sgml.cntr
	sgml2txt -man $?
	mv $?".man" $@

clean:
	rm -f *.sgml.cntr *.sgml.cntr.man *.man
