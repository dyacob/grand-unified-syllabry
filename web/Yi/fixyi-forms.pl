#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$f,$c1,$v,$c2,$t) = (0..7);

my ($lastc, $lastv, $lastf) = ("x", "x", 0);

while (<>) {
	next if /^#/;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel, $form ) = ( $line[$c1], $line[$v], $line[$f] );

	if ( $cons ne $lastc ) {
	    $lastf = 0;
	    $lastc = $cons;
	}
	if ( $vowel ne $lastv ) {
	    $lastf++;
	    $lastv = $vowel;
	}
	print "0 form!\n" unless ( $lastf );

	print "$line[$addr];  $line[$name];  $line[$family];  $lastf;  $line[$c1];  $line[$v];  $line[$c2];  $line[$t]";
}
