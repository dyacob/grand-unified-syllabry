#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;
my @VowelOrder =(
    "*", "&#x0259;", "&#x028C;", "u", "i", "a", "e", "o", "&#x0268;",
    "&#x02B7;&#x0259;", "&#x02B7;i", "&#x02B7;a", "&#x02B7;e", "&#x02B7;",
);
my @ConsonantOrder =(
    "*", "&#x0295;", "b",  "d", "&#x0257;", "d'", "f", "g", "&#x014B;",
    "h", "&#x0127;", "&#x03BE;", "x",
    "j", "&#x02A4;", "k", "k'",
    "l", "m", "n", "&#x0272;", "p", "p'", "q", "r",
    "s", "s'", "&#x0283;", 
    "t", "t'", "&#x02A7;", "&#x02A7;'", "v", 
    "w", "z",  "&#x0292;"
);

while (<>) {
	next unless ( /ETHIOPIC/ );
	chomp;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel ) = ( $line[$c1], $line[$v] );
	
	$vowel ||= "*";
	$cons  ||= "*";
	$vowel =~ s/<(.*?)>/&#x$1;/g;
	$cons  =~ s/<(.*?)>/&#x$1;/g;

	#
	#  create an array for this coordinate
	#
	push ( @{$table{$cons}->{$vowel}}, $line[$addr] );
}

print<<TOP;
<html>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
  <title>Amharic in IPA Notation</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Amharic in IPA Notation</h1>

<div align="center">
<table border="1">
<tr>
  <th>&nbsp;</th>
TOP

foreach ( @VowelOrder ) {
	print "  <th>$_</th>\n";
}
print "</tr>\n";


foreach ( @ConsonantOrder ) {
	my $cons = $_;
	next unless ( $table{$cons} );
	print "<tr>\n";
	print "  <th>$cons</th>\n";
	foreach my $vowel ( @VowelOrder ) {
		print "  <td>";
		if ( defined ($table{$cons}{$vowel}) ) {
		    my $print;
		    foreach my $v ( @{$table{$cons}{$vowel}} ) {
			$print .= "&#x$v;<br>";
		    }
		    $print =~ s/<br>$//;
		    print $print;
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
