
create_container = ../../scripts/create_container2

MANPAGEFILES = cfs.man \
               clearstats.man \
               clog.man \
               cmon.man \
               cpasswd.man \
               ctokens.man \
               cunlog.man \
               dirRepair.man \
               heal.man \
               hoard.man \
               mvdb.man \
               profoff.man \
               repair.man \
               spy.man \
               ttyfcon.man

all: $(MANPAGEFILES)

%.sgml.cntr: %.sgml
	  $(create_container) $?

%.man: %.sgml.cntr
	sgml2txt -man $?
	mv $?".man" $@

clean:
	rm -f *.sgml.cntr *.sgml.cntr.man *.man
