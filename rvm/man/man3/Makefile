
create_container = ../../../scripts/create_container

MANPAGEFILES = rvm_initialize.man \
   	       rvm_initialize.man \
               rvm_set_options.man \
   	       rvm_terminate.man \
               rvm_map.man \
   	       rvm_unmap.man \
   	       rvm_begin_transaction.man \
   	       rvm_set_range.man \
   	       rvm_modify_bytes.man \
   	       rvm_abort_transaction.man \
   	       rvm_end_transaction.man \
   	       rvm_flush.man \
   	       rvm_truncate.man \
   	       rvm_create_log.man \
   	       rvm_query.man \
   	       rvm_statistics.man \
   	       rvm_print_statistics.man \
   	       rvm_create_segment.man \
   	       rvm_load_segment.man \
   	       rds_malloc.man \
   	       rds_free.man \
   	       rds_fake_free.man \
   	       rds_init_heap.man \
   	       rds_load_heap.man \
   	       rds_zap_heap.man \
   	       rds_prealloc.man \
   	       rds_statistics.man

all: $(MANPAGEFILES)

%.sgml.cntr: %.sgml
	  $(create_container) $?

%.man: %.sgml.cntr
	sgml2txt -man $?
	mv $?".man" $@

clean:
	rm -f *.sgml.cntr *.sgml.cntr.man *.man
