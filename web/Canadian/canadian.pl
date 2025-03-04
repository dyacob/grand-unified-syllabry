#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;
my @VowelOrder =(
    "*",
    "a", "a&#x02D0;", "ai", "aai",
    "e", "e&#x02D0;",
    "i", "i&#x02D0;",
    "o", "o&#x02D0;",
    "u", "u&#x02D0;",
    "&#x02B7;a", "&#x02B7;a&#x02D0;",
    "&#x02B7;e", "&#x02B7;e&#x02D0;",
    "&#x02B7;i", "&#x02B7;i&#x02D0;",
    "&#x02B7;o", "&#x02B7;o&#x02D0;",
    "&#x02B7;u",
);
my @ConsonantOrder =(
    "*", "b", "d", "dl", "&#x02A3;", "f", "g", "&#x014B;", "gh",
    "h", "hk", "j", "&#x02A4;", "&#x02A4;&#x02A4;", "k", "kh", "kk",
    "l", "lh", "m", "mh", "n", "nh", "nng", "p", "q", "r",
    "s", "sc", "&#x0283;", "sk", "sp", "st",
    "t", "&#x02A6;", "&#x02A7;", "tl", "tlh", "tt", "tth", "tts", "&#x0398;",
	"w", "z"
);

while (<>) {
	next unless ( /CANADIAN/ );
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
  <title>Canadian in IPA Notation</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Canadian in IPA Notation</h1>

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
	print "<tr align=\"center\">\n";
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
