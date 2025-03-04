#!/usr/bin/perl -w

use strict;

my ($addr,$name,$family,$form,$c1,$v,$c2,$t) = (0..7);
my %Family;
my %table;
my $maxForm = 0;

while (<>) {
	next if ( /^#/ );
	chomp;
	my @line = split ( /;\s+/ );

	$maxForm = $line[$form] if ($line[$form] > $maxForm);

	my $syl;
	if ( $line[$t] eq "T" ) {
	    $syl = "<span style=\"color:red\">&#x$line[$addr];</span>";
	}
	elsif ( $line[$t] eq "X" ) {
	    $syl = "<span style=\"color:blue\">&#x$line[$addr];</span>";
	}
	elsif ( $line[$t] eq "P" ) {
	    $syl = "<span style=\"color:green\">&#x$line[$addr];</span>";
	}
	else {
	    $syl = "&#x$line[$addr];";
	}
	if ( defined($Family{$line[$family]}[$line[$form]-1]) ) {
	    $Family{$line[$family]}[$line[$form]-1] .= "<br>$syl";
	}
	else {
	    $Family{$line[$family]}[$line[$form]-1] = $syl;
	}
}

print<<TOP;
<html>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
  <title>Yi Families &amp; Forms</title>
</head>
<body bgcolor="#fffffh">

<h1 align="center">Yi Families &amp; Forms</h1>

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
	print "<tr align=\"center\">\n";
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
