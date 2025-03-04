#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /;  (CHEROKEE)/ ) {
		print;
		next;
	}
	chomp;
	my @line = split ( /;\s+/ );

	
	$line[$c1] =~ tr/A-Z/a-z/;
	$line[$c1] =~ s/qu/kw/;
	$line[$c1] =~ s/y/j/;
	$line[$c1] = s/ts/<02A6>/;

	#
	# modify vowels as needed:
	#
	if ( $line[$v] ) {
		$line[$v] =~ s/A/a/;
		$line[$v] =~ s/E/e/;
		$line[$v] =~ s/I/i/;
		$line[$v] =~ s/O/o/;
		$line[$v] =~ s/U/u/;
		$line[$v] =~ s/V/<028C>/;
	}

	foreach (@line) {
		print "$_;  ";
	}
	print "\n";
}
