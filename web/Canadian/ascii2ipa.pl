#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /;  CANADIAN/ ) {
		print;
		next;
	}
	chomp;
	my @line = split ( /;\s+/ );

	if ( $line[$c2] ) {
		$line[$c2] =~ tr/A-Z/a-z/;
	}
	else {
		$line[$c2] = "|";
	}

	if ( $line[$c1] ) {
		$line[$c1] =~ tr/A-Z/a-z/;

	    $line[$c1] =~ s/^ts/<02A6>/;
		$line[$c1] =~ s/^th/<0398>/;
		$line[$c1] =~ s/^sh/<0283>/;
		$line[$c1] =~ s/^ch/<02A7>/;
		$line[$c1] =~ s/^ng/<014B>/;
		$line[$c1] =~ s/^jj/<02A4><02A4>/g;
		$line[$c1] =~ s/^j/<02A4>/g;
		$line[$c1] =~ s/^y/j/;

		$line[$c1] =~ s/dz/<02A3>/;

	}
	else {
		$line[$c1] = "|";
	}

	#
	# modify vowels as needed:
	#
	if ( $line[$v] ) {
		$line[$v] =~ tr/A-Z/a-z/;
		# $line[$v] =~ s/v/<0259>/;  schwa
		$line[$v] =~ s/w/<02B7>/;
		$line[$v] =~ s/aa$/a<02D0>/;
		$line[$v] =~ s/ee$/e<02D0>/;
		$line[$v] =~ s/ii$/i<02D0>/;
		$line[$v] =~ s/oo$/o<02D0>/;
		$line[$v] =~ s/uu$/u<02D0>/;
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
