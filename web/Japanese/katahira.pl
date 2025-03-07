#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;
my @SortOrder;

while (<>) {
	next unless ( /;  KATAKANA/ );
	# next unless ( /;  HIRAGANA/ );
	chomp;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel ) = ( $line[$c1], $line[$v] );
	
	$vowel ||= "*";
	$cons  ||= "*";
	$vowel =~ s/<(.*?)>/&#x$1;/;
	$cons  =~ s/<(.*?)>/&#x$1;/;

	unless ( $Vowels{$vowel} ) {
		$Vowels{$vowel} = 1;
		push ( @SortOrder, $vowel );
	}

	#
	#  create an array for this coordinate
	#
	$table{$cons}->{$vowel} = $line[$addr];
}

print<<TOP;
<html>
<head>
  <title>Katakana in IPA Notation</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Katakana in IPA Notation</h1>

<div align="center">
<table border="1">
<tr>
  <th>&nbsp;</th>
TOP

foreach ( @SortOrder ) {
	print "  <th>$_</th>\n";
}
print "</tr>\n";


foreach ( sort keys %table ) {
	my $cons = $_;
	print "<tr>\n";
	print "  <th>$cons</th>\n";
	foreach my $vowel ( @SortOrder ) {
		print "  <td>";
		if ( defined ($table{$cons}{$vowel}) ) {
			print "&#x$table{$cons}{$vowel};";
		}
		else {
			print "&nbsp;";
		}
		print "</td>\n";
	}
	print "</tr>\n";

}


print<<BOTTOM;
</table>

</body>
</html>
BOTTOM
