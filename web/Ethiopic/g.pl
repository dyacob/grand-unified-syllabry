#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);

while (<>) {
	unless ( /;  <02B7>/ ) {
		print;
		next;
	}
	my $line = $_;
	chomp;
	my @line = split ( /;\s+/ );

	unless ( $line[$form] eq "<02B7>" ) {
		print $line;
		next;
	}
	else {
	    $line[$form] = "2";
	}

	my $print;
	foreach (@line) {
		$print .= "$_;  ";
	}
	$print =~ s/\|//g;
	print "$print\n";
}
