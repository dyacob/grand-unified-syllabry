#!/usr/bin/perl -w

use strict;

my %table = ();
my %Vowels = ();
# my @vowels = ();
my @SortOrder = (
	"V",  "U",  "I",  "II",  "A",  "AA",  "E",  "EE", "*" , "O",  "OO",
	"WV", "WU", "WI", "WII", "WA", "WAA", "WE", "WEE", "W", "WO", "WOO",
	"IE", "UO", "AAI", "AI", "UR", "Y", "YR"
);

while (<>) {
	next if /#/;
	chomp;
	s/; /;/g;
	my ($addr, $name, $f, $x, $y, $z, $t) = split (/;/);

	$addr .= "-$t" if ( $y && $t && ($t ne "M") );

	$y = "*" unless ( $y );
	$x = "*" unless ( $x );
	# push ( @vowels, $y ) unless ( $Vowels{$y} );
	$Vowels{$y} = 1;

	#
	#  create an array for this coordinate
	#
	$table{$x}->{$y} ||= ();

	#
	#  add address to the coordinate
	#
	push ( @{$table{$x}{$y}}, $addr );
}

# foreach ( sort keys %Vowels ) {
# 	print "$_\n";
# }
# my $vSize = (scalar keys %Vowels);
# my $sSize = (scalar @SortOrder);

# print "vSize = $vSize\nsSize = $sSize\n";

die ( "Vowels Hash out of sync with SortOrder Array" ) if ( (scalar keys %Vowels) ne (scalar @SortOrder) );

print<<TOP;
<html>
<head>
  <title>The Grand Unified Syllabary</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">The Grand Unified Syllabary</h1>

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
			foreach ( @{$table{$cons}{$vowel}} ) {
				next unless ( $_ );
				if ( /-/ ) {
					if ( /-T/ ) {
						s/-T//;
						print "<span style=\"color:red\">$_</span><br>";
					}
					elsif ( /-X/ ) {
						s/-X//;
						print "<span style=\"color:blue\">$_</span><br>";
					}
					else {
						s/-P//;
						print "<span style=\"color:green\">$_</span><br>";
					}
				}
				else {
					print "$_<br>";
				}
			}
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
