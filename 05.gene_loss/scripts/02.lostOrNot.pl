#! /usr/bin/env perl
use strict;
use warnings;

my $geneid=shift;

my @group1=("xaa","xab","xac","xad");
my @group2=("ST-1.1","ST-1.2","ST-1.3","ST-2.1","ST-2.2");
my $depth_file="$geneid.out";

if(-z "$geneid.gff"){
    die "$geneid is empty\n";
}

if(!-e $depth_file){
    die "run 01.prepare.pl <gene id> first!\n";
}
my $out="$geneid.status";

my %group;
foreach my $ind(@group1){
    $group{$ind}=1;
}
foreach my $ind(@group2){
    $group{$ind}=2;
}

open I,"< $depth_file";
<I>;
my %depth;
while (<I>) {
    chomp;
    my @a=split(/\s+/);
    my ($pos,$ind,$depth)=@a;
    next unless(exists $group{$ind});
    my $group=$group{$ind};
    $depth{$pos}{$group}+=$depth;
}
close I;

my %sta;
foreach my $pos(keys %depth){
    foreach my $group(sort keys %{$depth{$pos}}){
	my $depth=$depth{$pos}{$group};
	my $sta="mid";
	if($depth>10){
	    $sta="high";
	}
	elsif($depth==0){
	    $sta="low";
	}
	$sta{$pos}{$group}{$sta}++;
    }
}

my $len=keys %sta;
my $lost_in_group1=0;
my $lost_in_group2=0;
foreach my $pos(sort {$a<=>$b} keys %sta){
    my @state1=keys %{$sta{$pos}{1}};
    my @state2=keys %{$sta{$pos}{2}};
    my $state1=$state1[0];
    my $state2=$state2[0];
    # print "$pos\t$state1\t$state2\n";
    next if(@state1 > 1 || @state2 > 1);
    next if($state1 eq "mid" || $state2 eq "mid");
    next if($state1 eq $state2);
    if($state1 eq "low"){
        $lost_in_group1++;
    }
    elsif($state2 eq "low"){
        $lost_in_group2++;
    }
}

my $status="NA";
if($lost_in_group1/$len>=0.5){
    $status = "lost_in_group1";
}
if($lost_in_group2/$len>=0.5){
    $status = "lost_in_group2";
}
open O,"> $out";
print O "# geneid cds_len\tnum_lost_in_1\tnum_lost_in_2\tstatus\n";
print O "$geneid\t$len\t$lost_in_group1\t$lost_in_group2\t$status\n";
close O;
