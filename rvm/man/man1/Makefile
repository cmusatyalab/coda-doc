
create_container = ../../../scripts/create_container

MANPAGEFILES = rdsinit.man

# MANPAGEFILES = rdsinit.man \
#                rvmutl.man

all: $(MANPAGEFILES)

%.sgml.cntr: %.sgml
	  $(create_container) $?

%.man: %.sgml.cntr
	sgml2txt -man $?
	mv $?".man" $@

clean:
	rm -f *.sgml.cntr *.sgml.cntr.man *.man
