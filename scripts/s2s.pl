#!/usr/bin/perl
$TABLE="/home/braam/doc/scripts/s2s";
while ( <STDIN> ) {
    $text = $text . $_;
}
# print "--------->Before:***\n $text\n\n\n\n";
# print "****************************************************************\n";


# Usage: s2gsub( text, sc_b, sc_e, sg_b, sg_e,  )
# in the sc_e sc_b strings, parentheses need  \\ prepended 
#                                           (special in regexp)
#                  @           needs \@           (array eval)


sub cons {
    $_[0] . $_[1] . $_[2];
}

sub nullit {
    ""
}


sub nlcons {
    my ( $stuff );
    $stuff = $_[1];
    $stuff =~ s/\n/<P>\n/g;
#    print "------->$stuff<---------\n";
    $_[0] . $stuff . $_[2];
}

# Build name/val aary for copt
sub optstr2arg {
    my ( %vars );
    my ( $in, $out,  @manargs, $prm );

    $prm = $_[0];

    $prm =~ s/,\s*(desc|name)/SEPARATOR $1/m;
    @manargs = split(/\s*SEPARATOR\s*/,$prm);

    foreach ( @manargs ) { 
	($in , $out ) = split ( /\s*=\s*/, $_);
	$out =~ s/\"//sg;
	$vars{ $in } = $out;
    }
    %vars;
}
    
# now for man
sub manstr2arg {
    my ( %vars );
    my ( $in, $out,  @manargs, $prm );

    $prm = $_[0];

#    $prm =~ s/,\s*(desc|name)/SEPARATOR $1=/m;
    @manargs = split(/\s*,\s*/,$prm);

    foreach ( @manargs ) { 
	($in , $out ) = split ( /\s*=\s*/, $_);
	$out =~ s/\"//sg;
	$vars{ $in } = $out;
    }
    %vars;
}

# Dissect Scribe preamble
sub cman {
    my ($out, %vars, $name, $blurb, $chapter, $system);
    %vars = manstr2arg($_[1]);
    
    $name = $vars{"name"};
    $blurb = $vars{"blurb"};
    $chapter = $vars{"chapter"};
    $system = $vars{"system"};

    $out = "<!doctype linuxdoc system>\n\n";
    $out .= "<manpage TITLE=\"$name\" SECTNUM=$chapter>\n";
    $out .= "<sect1>NAME \n <P>$name - $blurb\n\n";
#    print "----5----->*$out*\n";
    $out;
}

sub copt {
    my ($out, %vars, $name, $desc);
    
    %vars = optstr2arg($_[1]);
    $name = $vars{"name"};
    $desc = $vars{"desc"};
#    print "--------> %vars\n";
#    print "--------> $desc\n";
#    print "**** \&copt: >str2arg: $name: \t$desc \n";

    $out = "<descrip>\n<tag>$name</tag>$desc\n<P></descrip>";
    $out;
}

#sub matstr {
#    my ($out);
#    if ($_[1]) {
#        $out = "([^()]*(\\([^()]*\\)[^()]*)*)";
#    }
#    else {
#        $out = "(.*?)";
#    }
#    $out;
#}

sub s2gsub {
    my ($thetext, $sc_b, $sc_e, $sg_b, $sg_e, $myfunc);
    my ($in);

    $thetext = $_[0];
    $sc_b = $_[1];
    $sc_e = $_[2];
    $sg_b = $_[3];
    $sg_e = $_[4];
    $myfunc = $_[5];
    $matfun = $_[6];

#    Match one level of optional nested parens
#    $sc_t = "([^()]*(\\([^()]*\\)[^()]*)*)";
#    $sc_t = "(.*?)";

    $in = $sc_b . "(.*?)" . $sc_e;
#    $in = &matstr($matfun);

#    print "******** \&s2gsub: \$in: $in **************\n";
#    print "********$sg_b**************\n";
#    print "********$sg_e**************\n";
#    print "********$myfunc(\"$sg_b\", \"$1\", \"$sg_e\");**************\n";

# /e evaluates the replacement string twice.  Warning $1 is only assigned when 
#    in the regexp, cannot be put in beforehand.
# /g usual multi replacement
# /s helps with multiline things.
# /m allows ^ and & to still match begin and end of line.

    if ( $thetext =~ /$in/gsm ) {
# 	print "HURRAY! *$1*\n";
#	print "$myfunc(\"$sg_b\", \"$1\", \"$sg_e\");\n"
#	print "**** \&s2gsub: \$myfunc: $myfunc: \t$sg_b \n\t$1 \n\t$sg_e\n";
    }

    $thetext =~ s/$in/"$myfunc(\"$sg_b\", '$1', \"$sg_e\");"/igsmee;
    $thetext;
}


# $sc_b = "\@BeginProse\\(DESCRIPTION\\)";
# $sc_e = "\@EndProse\\(\\)";


# $sg_b = "<B>";
# $sg_e = "</B>";

# $func = "\&cons";

#   if ( $text =~ /(\s\()(.*?)\)/ ) {
#       print "---> Yippeah:  $1 --- \n";
#       print "--->  LEFTPAREN $2 RIGHTPAREN\n"
#   }

#  Substitute ' LEFTPAREN' for \s( and RIGTHPAREN for )
$text =~ s/\s\(([^\)]*?)\)/ LEFTPAREN $1 RIGHTPAREN/gms;

# print "P1:\n$text\n";
# print "P1:\n$1\n";

#   if ( $text =~ /([^\@]\b\w+\()(.*?)\)/ ) {
#       print "---> Yippeah:  $1 --- $2 \n";
#       print "---> $1 LEFTPAREN $2 RIGHTPAREN\n"
#   }

$text =~ s/([^\@]\b\w+)\((.*?)\)/$1 LEFTPAREN $2 RIGHTPAREN/gms;
# print "P2:\n$text\n";

open(TABLE, $TABLE) || die "Can't open s2s!";

while (<TABLE> ) { 
    chop ;
    if ( /^\#/ ) {
	next;
    }
    if ( /^enough/ ) {
#	print "ENOUGH!\n";
	last;
    }
    @entry = split(/,/ , $_); 
    
#print "TABLE ENTRY:  @entry\n";
#print "ARG1: $entry[1]\n";

    $text = &s2gsub( $text, $entry[0], $entry[1], $entry[2], $entry[3], $entry[4]);

#    print "\n\n---> NEXT ITERATION  <----\n\n";
#    print $text;

#     print "--------->ATTEMPT 2<------------\n\n";


# @entry = ( "\@BeginProse\\(DESCRIPTION\\)", "\@EndProse\\(\\)", "<B>", "</B>", "\&cons" );
# $newtext = &s2gsub( $text, $entry[0], $entry[1], $entry[2], $entry[3], $entry[4]);
# print $newtext;
}


# restore the parenthesis
$text =~ s/ LEFTPAREN (.*?) RIGHTPAREN/ ($1)/gms;


$text .= "\n</manpage>\n";
print $text;

exit 0;

