#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %table = ();
my %Vowels = ();

my @VowelOrder =(
	"*", "&#x0268;", "&#x0259;", "&#x028C;",
	"a", "a&#x02D0;", "aai", "ai",
	"e", "e&#x02D0;",
	"i", "i&#x02D0;", "ie",
	"o", "o&#x02D0;",
	"u", "uo", "ur",
	"&#x02B7;", "&#x02B7;&#x0259;", "&#x02B7;&#x028C;", "&#x02B7;a", "&#x02B7;a&#x02D0;", 
	"&#x02B7;e", "&#x02B7;e&#x02D0;", "&#x02B7;i", "&#x02B7;i&#x02D0;", "&#x02B7;o", "&#x02B7;o&#x02D0;", "&#x02B7;u",
	"y", "&#x02B8;i", "yr", 
);
my @ConsonantOrder =(
	"*", "&#x0295;", 
	"b", "bb", "c", "ch", "d", "&#x0257;", "d'", "dd", "dl", "&#x02A3;",
	"f", "&#x0278;", "g", "gg", "&#x014B;", "gh",
	"h", "&#x0127;", "&#x03BE;", "x",
	"hk", "hl", "hm", 
	"hn", "hx", "j", "jj", "&#x02A4;", "&#x02A4;&#x02A4;",
	"k", "k'", "kh", "kk", 
	"l", "lh", "m", "mg", "mh",
	"n", "nb", "nd", "ng", "nh", "nj", "nng", "nr", "ny", "&#x0272;", "nz",
	"p", "p'", "q", "r", "rr",
	"s", "s'", "sc", "&#x0283;", "sh", "sk", "sp", "ss", "st",
	"t", "t'", "&#x02A6;", "&#x02A7;", "&#x02A7;'",
	"tl", "tlh", "tt", "tth", "tts", "ty", "&#x0398;",
	"v", "w", "y", 
	"z", "&#x0292;", "zh", "zz", 
);
while (<>) {
	next if /#/;
	chomp;
	s/; /;/g;

	my @line = split ( /;\s+/ );
	my ( $code, $cons, $vowel, $tone ) = ( $line[$addr], $line[$c1], $line[$v], $line[$t] );

	$code .= "-$tone" if ( $vowel && $tone && ($tone ne "M") );

	$vowel ||= "*";
	$cons  ||= "*";
	$vowel =~ s/<(.*?)>/&#x$1;/g;
	$cons  =~ s/<(.*?)>/$1/g;

	$Vowels{$vowel} = 1;

	#
	#  create an array for this coordinate
	#
	$table{$cons}->{$vowel} ||= ();

	#
	#  add address to the coordinate
	#
	push ( @{$table{$cons}{$vowel}}, $code );
}

# foreach ( sort keys %Vowels ) {
 # 	print "$_\n";
# }
# my $vSize = (scalar keys %Vowels);
# my $sSize = (scalar @VowelOrder);

# print "vSize = $vSize\nsSize = $sSize\n";

warn ( "Vowels Hash out of sync with VowelOrder Array" ) if ( (scalar keys %Vowels) ne (scalar @VowelOrder) );

print<<TOP;
<html>
<head>
  <META http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>The Grand Unified Syllabary</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">The Grand Unified Syllabary</h1>

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
	print "<tr align=\"center\">\n";
	print "  <th>$cons</th>\n";
	foreach my $vowel ( @VowelOrder ) {
		print "  <td>";
		if ( defined ($table{$cons}{$vowel}) ) {
			my $print;
			foreach ( @{$table{$cons}{$vowel}} ) {
				next unless ( $_ );
				if ( /-/ ) {
					if ( /-T/ ) {
						s/-T//;
						$print .= "<span style=\"color:red\">$_</span><br>";
					}
					elsif ( /-X/ ) {
						s/-X//;
						$print .= "<span style=\"color:blue\">$_</span><br>";
					}
					else {
						s/-P//;
						$print .= "<span style=\"color:green\">$_</span><br>";
					}
				}
				else {
					$print .= "$_<br>";
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
