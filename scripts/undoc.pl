#!/usr/bin/perl

if ($#ARGV < 0) {
    print "Usage: undoc filename ...\n";
    exit 0;
}

$tmpfn = "tmp" . $$;

foreach $fn (@ARGV) {
    open(FILE, $fn) or die "Can't open file $fn: $!\n";
    open(TMP, ">$tmpfn") or die "Can't open tmp file $tmpfn $!\n";
    print "filtering file $fn ...";
    $clean = 1;
    while ($line = <FILE>) {
	if ($line =~ /<!doctype/) {
	    # sanity check
	    if ($line  !~ />[ \t]*$/) {
		$clean = 0;
		print "\nOops !Something is wrong.  The current line is\n";
		print $line;
		printf "File %s is not filtered\n", $fn;
	    }
	} else {
	    print TMP $line;
	}
    }

    close FILE;
    close TMP;

    if ($clean) {
	rename $tmpfn, $fn or die "Can't rename $tmpfn to $fn: $!\n";
	print " succeed\n";
    }
}
