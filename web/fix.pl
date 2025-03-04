#!/usr/bin/perl -w

my %Hex = (
        0 => 0,
        1 => 1,
        2 => 2,
        3 => 3,
        4 => 4,
        5 => 5,
        6 => 6,
        7 => 7,
        8 => 8,
        9 => 9,
        A => 10,
        B => 11,
        C => 12,
        D => 13,
        E => 14,
        F => 15,
);

sub foo {
        my ($a,$b,$c,$d) = split (//, shift);
        $a = $Hex{$a};
        $b = $Hex{$b};
        $c = $Hex{$c};
        $d = $Hex{$d};
        my $num = $a*(16**3)+$b*(16**2)+$c*(16)+$d;
        $num;
}
while (<>) {
	# s/>([0-9A-F]{4})</>&#x$1;</og;
	s/>([0-9A-F]{4})</">&#".foo($1).";<"/eog;
	print;
}
