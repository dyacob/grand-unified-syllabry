#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;
my @VowelOrder =(
    "*", "a", "i", "&#x02B8;i", "u", "e", "o", "&#x02D0;"
    # "a", "i", "&#x02B8;i", "u", "e", "o",
);
my @ConsonantOrder =(
    "*", "b", "d", "&#x02A3;", "g", "h", "&#x0278;",
    "j", "k", "m", "n", "p", "r", "s", "t",
    "&#x02A6;", "v", "w", "z"
);


while (<>) {
	next unless ( /CIRCLED/ );
	# next unless ( /HALFWIDTH/ );
	# next unless ( /KATAKANA/ && !/CIRCLED/ && !/HALFWIDTH/ );
	# next unless ( /;  HIRAGANA/ );
	chomp;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel ) = ( $line[$c1], $line[$v] );
	
	$vowel ||= "*";
	$cons  ||= "*";
	$vowel =~ s/<(.*?)>/&#x$1;/g;
	$cons  =~ s/<(.*?)>/&#x$1;/;

	# unless ( $Vowels{$vowel} ) {
	# 	$Vowels{$vowel} = 1;
		# push ( @SortOrder, $vowel );
	# }

	#
	#  create an array for this coordinate
	#
	push ( @{$table{$cons}->{$vowel}}, $line[$addr] );
}

print<<TOP;
<html>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
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

foreach ( @VowelOrder ) {
	print "  <th>$_</th>\n";
}
print "</tr>\n";


# foreach ( sort keys %table ) {
foreach ( @ConsonantOrder ) {
	my $cons = $_;
	next unless ( $table{$cons} );
	print "<tr>\n";
	print "  <th>$cons</th>\n";
	foreach my $vowel ( @VowelOrder ) {
		print "  <td>";
		if ( defined ($table{$cons}{$vowel}) ) {
		    # print "&#x$table{$cons}{$vowel};";
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
