#! /usr/bin/env perl
use strict;
use warnings;

my $input_lst="transcriptID_name.table";
my $outdir="genes";
`mkdir $outdir` if(!-e $outdir);
my $now=$ENV{'PWD'};
my $step1="$now/scripts/01.prepare.pl";
my $step2="$now/scripts/02.lostOrNot.pl";

open O,"> $0.sh";
open I,"< $input_lst";
<I>;
while (<I>) {
    chomp;
    my @a=split(/\s+/);
    my $geneid=$a[0];
    print O "cd $now/$outdir; mkdir $geneid; cd $geneid; perl $step1 $geneid; perl $step2 $geneid; cd $now\n";
}
close I;
close O;
