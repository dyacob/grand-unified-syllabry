#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /;  (ETHIOPIC)/ ) {
		print;
		next;
	}
	chomp;
	my @line = split ( /;\s+/ );

	$line[$c2] = "|" unless ( $line[$c2] );

	if ( $line[$name] =~ /PHARYNGEAL/ ) {
		$line[$c1] = "<0295>";
	}
	elsif ( $line[$c1] ) {
		$line[$c1] =~ tr/A-Z/a-z/;

		#
		#  Ge'ez, Tigrigna
		#
		$line[$c1] =~ s/hh/<0127>/;  # h-bar
		#
		# Amharic
		#
		# $line[$c1] =~ s/hh/h/;

		$line[$c1] =~ s/sh/<0283>/;
		$line[$c1] =~ s/zh/<0292>/;
		$line[$c1] =~ s/ph/p'/;
		$line[$c1] =~ s/th/t'/;
		$line[$c1] =~ s/ch/<02A7>'/;

		$line[$c1] =~ s/q$/k'/;
		$line[$c1] =~ s/qh/q/;       # not sure about this

		$line[$c1] =~ s/c/<02A7>/;

		#
		#  Ge'ez
		#
		# $line[$c1] =~ s/^x/<03BE>/;  # small-xi
		#
		#  Amharic, Tigrigna
		#
		$line[$c1] =~ s/^x/h/;


		#
		#  Tigrigna, other
		#
		$line[$c1] =~ s/kx/x/;
		#
		#  Amharic
		#
		# $line[$c1] =~ s/kx/h/;

		$line[$c1] =~ s/ny/<0272>/;
		$line[$c1] =~ s/gg/<014B>/;

		$line[$c1] =~ s/j/<02A4>/;
		$line[$c1] =~ s/y/j/;

		$line[$c1] =~ s/ts/s'/;

		#
		#  Ge'ez
		#
		# $line[$c1] =~ s/tz/d'/;
		#
		#  Amharic, Tigrigna
		#
		$line[$c1] =~ s/tz/s'/;

		$line[$c1] =~ s/dd/<0257>/;  # d-hook-top

		#
		#  Ge'ez
		#
		# $line[$c1] =~ s/^s$/<0283>/; # In Ge'ez

		$line[$c1] =~ s/sz/s/;
	}
	else {
		$line[$c1] = "|";
	}

	if ( ($line[$addr] eq "12A5") || ($line[$addr] eq "12D5") ) {
		$line[$v] = "<0268>";
	}

	#
	# modify vowels as needed:
	#
	if ( $line[$v] ) {
		$line[$v] =~ tr/A-Z/a-z/;
		$line[$v] =~ s/v/<0259>/;
		$line[$v] =~ s/w/<02B7>/;
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
