Summary: Coda documentation
Name: coda-doc
Version: 4.3.13
Release: 2
Copyright: Copright CMU 
Group: Base
Source: coda-doc-4.3.13.tgz
# BuildArchitectures: noarch

%description
This package contains coda man pages and manuals.

%prep
%setup

%build
./configure --prefix=/usr

make man
make manual-html
make manual-ps
make rvm_manual-html
make rvm_manual-ps

%install

make man-install
make doc-install
if [ ! -d /usr/doc/coda-4.3.13 ]; then
	mkdir /usr/doc/coda-4.3.13
fi
cp -r install/* /usr/doc/coda-4.3.13



%files
/usr/man/man1/cpasswd.man
/usr/man/man1/clog.man
/usr/man/man1/repair.man
/usr/man/man1/ctokens.man
/usr/man/man1/cunlog.man
/usr/man/man1/spy.man
/usr/man/man1/mvdb.man
/usr/man/man1/hoard.man
/usr/man/man1/cmon.man
/usr/man/man1/filcon.man
/usr/man/man1/cfs.man
/usr/man/man3/histo.man
/usr/man/man3/timing.man
/usr/man/man5/passwd_coda.man
/usr/man/man5/user_coda.man
/usr/man/man5/vsgdb.man
/usr/man/man5/maxgroupid.man
/usr/man/man5/backuplogs.man
/usr/man/man5/vstab.man
/usr/man/man5/vicetab.man
/usr/man/man5/dumplist.man
/usr/man/man5/servers.man
/usr/man/man5/vrdb.man
/usr/man/man5/groups_coda.man
/usr/man/man5/volumelist.man
/usr/man/man5/dumpfile.man
/usr/man/man5/multicastagents.man
/usr/man/man5/multicastgroups.man
/usr/man/man5/vrlist.man
/usr/man/man8/vol-dump.man
/usr/man/man8/addserver.man
/usr/man/man8/updatesrv.man
/usr/man/man8/clone.man
/usr/man/man8/createvol.man
/usr/man/man8/srv.man
/usr/man/man8/updateclnt.man
/usr/man/man8/startserver.man
/usr/man/man8/pwd2pdb.man
/usr/man/man8/vol-purge.man
/usr/man/man8/venus.man
/usr/man/man8/merge.man
/usr/man/man8/installserver.man
/usr/man/man8/replay.man
/usr/man/man8/vol-create.man
/usr/man/man8/authmon.man
/usr/man/man8/auth2.man
/usr/man/man8/updatemon.man
/usr/man/man8/vutil.man
/usr/man/man8/bldvldb.man
/usr/man/man8/initpw.man
/usr/man/man8/norton.man
/usr/man/man8/au.man
/usr/man/man8/createvol_rep.man
/usr/man/man8/readdump.man
/usr/man/man8/purgevol_rep.man
/usr/man/man8/purgevol.man
/usr/man/man8/pcfgen.man
/usr/man/man8/volutil.man
/usr/man/man8/backup.man
/usr/man/man1/rvmutl.man
/usr/man/man1/rdsinit.man
/usr/man/man3/rvm_truncate.man
/usr/man/man3/rvm_statistics.man
/usr/man/man3/rvm_end_transaction.man
/usr/man/man3/rds_zap_heap.man
/usr/man/man3/rvm_print_statistics.man
/usr/man/man3/rds_init_heap.man
/usr/man/man3/rds_fake_free.man
/usr/man/man3/rvm_load_segment.man
/usr/man/man3/rvm_query.man
/usr/man/man3/rds_statistics.man
/usr/man/man3/rvm_unmap.man
/usr/man/man3/rvm_create_log.man
/usr/man/man3/rds_load_heap.man
/usr/man/man3/rvm_map.man
/usr/man/man3/rvm_flush.man
/usr/man/man3/rvm_modify_bytes.man
/usr/man/man3/rvm_initialize.man
/usr/man/man3/rds_malloc.man
/usr/man/man3/rvm_terminate.man
/usr/man/man3/rvm_set_options.man
/usr/man/man3/rds_free.man
/usr/man/man3/rds_prealloc.man
/usr/man/man3/rvm_begin_transaction.man
/usr/man/man3/rvm_set_range.man
/usr/man/man3/rvm_create_segment.man
/usr/man/man3/rvm_abort_transaction.man
/usr/doc/coda-4.3.13
