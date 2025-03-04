#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /;  (HIRAGANA|KATAKANA)/ ) {
		print;
		next;
	}
	chomp;
	my @line = split ( /;\s+/ );

	
	#
	# For Katakana & Hiragana convert:
	# consonants:  sh, ch, ts, y
	#     vowels:  a, i, u, e, o
	#

	$line[$c1] =~ tr/A-Z/a-z/;

	$line[$c1] = "sh" if ( $line[$addr] eq "3057"
	                       || $line[$addr] eq "30B7" );
	$line[$c1] = "ch" if ( $line[$addr] eq "3061"
	                       || $line[$addr] eq "30C1" );
	$line[$c1] = "ts" if ( $line[$addr] eq "3064"
	                       || $line[$addr] eq "30C4" );

	$line[$c1] =~ s/ch/t<0283>/;
	$line[$c1] =~ s/sh/<0283>/;   # Small Esh is 0283
	# $line[$c1] =~ s/ts//;       # The "ts" phoneme should be mapped here
	$line[$c1] =~ s/y/j/;

	#
	# modify vowels as needed:
	#
	if ( $line[$v] ) {
		$line[$v] =~ s/A/a:/;
		$line[$v] =~ s/I/i:/;
		$line[$v] =~ s/U/u:/;
		$line[$v] =~ s/E/e<026A>/;
		$line[$v] =~ s/O/o/;
	}

	foreach (@line) {
		print "$_;  ";
	}
	print "\n";
}
