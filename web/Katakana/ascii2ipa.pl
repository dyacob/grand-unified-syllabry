#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /KATAKANA/ ) {
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
	    $line[$c1] = "<0278>" if ( $line[$addr] eq "30D5" 
	                               || $line[$addr] eq "32E9"
	                               || $line[$addr] eq "FF8A" );

	    # ts ligature
	    # 
	    $line[$c1] = "<02A6>" if ( $line[$addr] eq "30C1"
	                               || $line[$addr] eq "30C4"
	                               || $line[$addr] eq "32E0"
	                               || $line[$addr] eq "32E1"
	                               || $line[$addr] eq "FF81"
	                               || $line[$addr] eq "FF82" );

	    # dz ligature
	    # 
	    $line[$c1] = "<02A3>" if ( $line[$addr] eq "30C2"
	                               || $line[$addr] eq "30C5" );

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
	    $line[$v] = "|"  if ( $line[$addr] eq "30C3"
		                    || $line[$addr] eq "FF6F" );

	    $line[$v] = "<02B8>i" if ( $line[$addr] eq "30C1"     # ts
		                         || $line[$addr] eq "30C2"    # dz
	                             || $line[$addr] eq "30D2"    # h
	                             || $line[$addr] eq "30B7"    # s
	                             || $line[$addr] eq "30B8"    # z

	                             || $line[$addr] eq "32DF"    # ts
	                             || $line[$addr] eq "FF81"    # ts
	                             || $line[$addr] eq "32EA"    # h
	                             || $line[$addr] eq "FF8B"    # h
	                             || $line[$addr] eq "32DB"    # s
	                             || $line[$addr] eq "FF7C"    # s
	                             );
	}
	elsif ( $line[$addr] eq "30FC" || $line[$addr] eq "FF70" ) {
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
