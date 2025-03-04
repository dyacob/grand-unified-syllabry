#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %Consonants;

while (<>) {
	next if /^#/;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel ) = ( $line[$c1], $line[$v] );

	if ( $vowel ) {
		$vowel =~ s/<(.*?)>/&#x$1;/g;
		$Vowels{$vowel}    = 1;
	}
	if ( $cons ) {
		$cons  =~ s/<(.*?)>/&#x$1;/g;
		$Consonants{$cons} = 1;
	}

}

print "\@Vowels =(\n\t";
my $i = 0;
foreach (sort keys %Vowels) {
	print "\"$_\", ";
	$i++;
	print "\n\t" unless ( $i%8 );
}
print "\n);\n";

print "\@Consonants =(\n\t";
$i = 0;
foreach (sort keys %Consonants) {
	print "\"$_\", ";
	$i++;
	print "\n\t" unless ( $i%8 );
}
print "\n);\n";
