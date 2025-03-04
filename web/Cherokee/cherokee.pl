#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;
my @VowelOrder =(
    "*", "a", "e", "i", "o", "u", "&#x028C;",
    "&#x02B7;a", "&#x02B7;e", "&#x02B7;i", "&#x02B7;o", "&#x02B7;u", "&#x02B7;&#x028C;",
);
my @ConsonantOrder =(
    "*", "d", "dl", "g", "h", "hn", "j",
    "k", "l", "m", "n", "s", "t", "tl",
    "ts", "w",
);

while (<>) {
	next unless ( /CHEROKEE/ );
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
  <title>Cherokee in IPA Notation</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Cherokee in IPA Notation</h1>

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
