#! /usr/bin/perl

use Getopt::Long;

GetOptions("rel=s" => \$rel, "version=s" => \$version);

if ( ! $rel || ! $version ) {
    print "Usage $0 --rel=release --version=cvs-version \n";
    exit 1;
}


$dir="coda-doc-$version-$rel";
$specfile="/usr/src/redhat/SPECS/$dir.spec";
print "Will create specfile $specfile\n";

open(SPEC, ">$specfile");
while ( <> ) {
    ~ s/\@RELEASE\@/$rel/g;
    ~ s/\@VERSION\@/$version/g;
    print SPEC $_;
    print $_
}

print "Now run as root: rpm -ba -v $specfile\n";

print "Exit code $?\n";
