#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Vowels;
my %table;

my @VowelOrder =(
	"a", "e", "i", "ie", "o", "u", "uo", "ur", 
	"y", "yr", 
);
my @ConsonantOrder =(
	"b", "bb", "c", "ch", "d", "dd", "f", "g", 
	"gg", "h", "hl", "hm", "hn", "hx", "j", "jj", 
	"k", "l", "m", "mg", "n", "nb", "nd", "ng", 
	"nj", "nr", "ny", "nz", "p", "q", "r", "rr", 
	"s", "sh", "ss", "t", "v", "w", "x", "y", 
	"z", "zh", "zz", 
);

while (<>) {
	next unless ( /YI/ );
	chomp;
	my @line = split ( /;\s+/ );

	my ( $cons, $vowel, $tone ) = ( $line[$c1], $line[$v], $line[$t] );
	
	$vowel ||= "*";
	$cons  ||= "*";
	$vowel =~ s/<(.*?)>/&#x$1;/g;
	$cons  =~ s/<(.*?)>/&#x$1;/g;

	#
	#  create an array for this coordinate
	#
	my $push = $line[$addr];
	$push.= "-$tone" if ( $vowel && $tone && ($tone ne "M") );
	push ( @{$table{$cons}->{$vowel}}, $push );
}

print<<TOP;
<html>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
  <title>Yi in IPA Notation</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Yi in IPA Notation</h1>

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
		    foreach ( @{$table{$cons}{$vowel}} ) {
			if ( /-/ ) {
				if ( /-T/ ) {
					s/-T//;
					$print .= "<span style=\"color:red\">&#x$_;</span><br>";
				}
				elsif ( /-X/ ) {
					s/-X//;
					$print .= "<span style=\"color:blue\">&#x$_;</span><br>";
				}
				else {
					s/-P//;
					$print .= "<span style=\"color:green\">&#x$_;</span><br>";
				}
			}
			else {
			    $print .= "&#x$_;<br>";
			}
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
