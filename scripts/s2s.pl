#!/usr/bin/perl


while ( <STDIN> ) {
    $text = $text . $_;
}
## print "--------->Before:***\n $text\n\n\n\n";




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

sub str2arg {
    my ( %vars );
    my ( $in, $out,  @manargs );

    @manargs = split(/\s*,\s*/,$_[0]);

    foreach ( @manargs ) { 
	($in , $out ) = split ( /\s*=\s*/, $_);
	$out =~ s/\"//sg;
	$vars{ $in } = $out;
    }
    %vars;
}
    
sub cman {
    my ($out, %vars, $name, $blurb, $chapter, $system);
    %vars = str2arg($_[1]);
    
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
    
    %vars = str2arg($_[1]);
    $name = $vars{"name"};
    $desc = $vars{"desc"};
#     print "--------> %vars\n";
#     print "--------> $desc\n";

    $out = "<descrip>\n<tag>$name</tag>$desc\n</descrip>";
    $out;
}

sub s2gsub {
    my ($thetext, $sc_b, $sc_e, $sg_b, $sg_e, $myfunc);
    my ($in);

    $thetext = $_[0];
    $sc_b = $_[1];
    $sc_e = $_[2];
    $sg_b = $_[3];
    $sg_e = $_[4];
    $myfunc = $_[5];


    $in = $sc_b . "(.*?)" . $sc_e;

#     print "********$in**************\n";
#     print "********$sg_b**************\n";
#     print "********$sg_e**************\n";
#     print "********$myfunc(\"$sg_b\", \"$1\", \"$sg_e\");**************\n";
    

# /e evaluates the replacement string twice.  Warning $1 is only assigned when 
#    in the regexp, cannot be put in beforehand.
# /g usual multi replacement
# /s helps with multiline things.
# /m allows ^ and & to still match begin and end of line.

     if ( $thetext =~ /$in/gsm ) {
# 	print "HURRAY! *$1*\n";
#	print "$myfunc(\"$sg_b\", \"$1\", \"$sg_e\");\n"
     }

    $thetext =~ s/$in/"$myfunc(\"$sg_b\", '$1', \"$sg_e\");"/igsmee;
    $thetext;
}




# $sc_b = "\@BeginProse\\(DESCRIPTION\\)";
# $sc_e = "\@EndProse\\(\\)";


# $sg_b = "<B>";
# $sg_e = "</B>";

# $func = "\&cons";

open(TABLE, "s2s") || die "Can't open s2s!";

while (<TABLE> ) { 
    chop ;
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

$text .= "\n</manpage>\n";
print $text;

exit 0;

