#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

my %Consonants = ();

while (<>) {
	next unless ( /CANADIAN/ );
	chomp;
	my @line = split ( /;\s+/ );

	$Consonants{$line[$c1]} ||= 1;
}

foreach ( sort keys %Consonants ) {
	print "$_\n";
}
