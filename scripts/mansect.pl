#!/usr/bin/perl

if ($#ARGV < 0) {
    print "Usage: mansect filename ...\n";
    exit 0;
}

$tmpfn = "tmp" . $$;

foreach $fn (@ARGV) {
    open(FILE, $fn) or die "Can't open file $fn: $!\n";
    open(TMP, ">$tmpfn") or die "Can't open tmp file $tmpfn $!\n";
    print "filtering file $fn ...";
    $clean = 1;
    while (<FILE>) {
	s/<sect1>[\s]*name\b/<sect1>NAME/i;
	s/<sect1>[\s]*synopsis\b/<sect1>SYNOPSIS/i;
	s/<sect1>[\s]*description\b/<sect1>DESCRIPTION/i;
	s/<sect1>[\s]*diagnostics\b/<sect1>DIAGNOSTICS/i;
	s/<sect1>[\s]*see also\b/<sect1>SEE ALSO/i;
	s/<sect1>[\s]*Author\b/<sect1>AUTHOR/i;
	s/<sect1>[\s]*bugs\b/<sect1>BUGS/i;
	s/<sect1>/<mansect>/;
	print TMP $_;
    }

    close FILE;
    close TMP;

    if ($clean) {
	rename $tmpfn, $fn or die "Can't rename $tmpfn to $fn: $!\n";
	print " succeed\n";
    }
}
