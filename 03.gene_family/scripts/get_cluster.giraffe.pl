#!/usr/bin/perl
use strict;
open IN,@ARGV[0] || die $!;
open OUT,">giraffe.expansion.txt" || die $!;
open OUT2,">giraffe.constraction.txt" || die $!;
my$p;
while(<IN>){
chomp;
my @info=split(/\s+/);
my $id=$info[0];
my $want=$1 if ($info[1]=~/giraffe\_(\d+)/);

my $ans=$2 if ($info[1]=~/ST\_([^_]+)\_(\d+)/);
#print "$want\t$ans\n";
if ($want > $ans){
	$p=$info[2];
	print OUT "$id\t$p\n";}
if ($want < $ans){
	$p=$info[2];
print OUT2 "$id\t$p\n";
}
}
close IN;
close OUT;
close OUT2;
