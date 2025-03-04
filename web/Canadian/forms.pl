#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Family;
my %table;
my $maxForm = 0;

while (<>) {
	next unless ( /CANADIAN/ );
	chomp;
	my @line = split ( /;\s+/ );

	$maxForm = $line[$form] if ($line[$form] > $maxForm);

	if ( defined($Family{$line[$family]}[$line[$form]-1]) ) {
	    $Family{$line[$family]}[$line[$form]-1] .= "<br>&#x$line[$addr];";
	}
	else {
	    $Family{$line[$family]}[$line[$form]-1] = "&#x$line[$addr];";
	}
}

print<<TOP;
<html>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
  <title>Canadian Families &amp; Forms</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Canadian Families &amp; Forms</h1>

<div align="center">
<table border="1">
<tr>
  <th>&nbsp;</th>
TOP

for( my $i = 1; $i <= $maxForm; $i++ )  {
	print "  <th>[:%$i:]</th>\n";
}
print "</tr>\n";


foreach ( sort keys %Family ) {
	my $family = $_;
	print "<tr>\n";
	print "  <th>[=&#x$family;=]</th>\n";
	for( my $i = 1; $i <= $maxForm; $i++ )  {
		print "  <td>";
		if ( defined ($Family{$family}[$i-1]) ) {
			print $Family{$family}[$i-1];
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
