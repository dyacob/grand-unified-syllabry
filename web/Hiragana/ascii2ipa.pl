#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /HIRAGANA/ ) {
	    print;
	    next;
	}
	chomp;
	my @line = split ( /;\s+/ );

	$line[$c2] = "|" unless ( $line[$c2] );
	
	if ( $line[$name] =~ /SMALL/ ) {
	    $line[$c1] =~ tr/A-Z/a-z/;
	}
	elsif ( $line[$c1] ) {

	    $line[$c1] =~ tr/A-Z/a-z/;

	    # phi 
	    # 
	    $line[$c1] = "<0278>" if ( $line[$addr] eq "3075" );

	    # ts ligature
	    # 
	    $line[$c1] = "<02A6>" if ( $line[$addr] eq "3061"
	                               || $line[$addr] eq "3064" );

	    # dz ligature
	    # 
	    $line[$c1] = "<02A3>" if ( $line[$addr] eq "3062"
	                               || $line[$addr] eq "3065" );

	    $line[$c1] =~ s/y/j/;

	}
	else {
	    $line[$c1] = "|";
	}

	#
	# modify vowels as needed:
	#
	if ( $line[$v] ) {
	    $line[$v] =~ s/A/a/;
	    $line[$v] =~ s/I/i/;
	    $line[$v] =~ s/U/u/;
	    $line[$v] =~ s/E/e/;
	    $line[$v] =~ s/O/o/;
	    $line[$v] = "|"  if ( $line[$addr] eq "3063" );
	    $line[$v] = "<02B8>i" if ( $line[$addr] eq "3061"     # ts
		                         || $line[$addr] eq "3062"    # dz
	                             || $line[$addr] eq "3072"    # h
	                             || $line[$addr] eq "3057"    # s
	                             || $line[$addr] eq "3058" ); # z
	}
	elsif ( $line[$addr] eq "30FC" ) {
	    $line[$v] = "<02D0>";
	}
	else {
	    $line[$v]  = "|";
	}

	my $print;
	foreach (@line) {
		$print .= "$_;  ";
	}
	$print =~ s/\|//g;
	print "$print\n";

}
