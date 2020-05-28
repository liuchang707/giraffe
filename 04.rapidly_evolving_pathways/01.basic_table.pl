#! /usr/bin/env perl
use strict;
use warnings;

## fengchenguang modified at 2019-7-22

my $Gene2GoID="bta00001.keg";
my $dnds="All.freeratio.result.out";
my $fore="Giraffe3";
my $back="Okapi";

my %Gene2GoID;
my %GO_count;
open I,"< $Gene2GoID";
while (<I>) {
    chomp;
    my @a=split(/\s+/);
    my $gene=shift @a;
    foreach my $go(@a){
        $Gene2GoID{$gene}{$go}=1;
        $GO_count{$go}++;
    }
}
close I;

my %sum;
my %go_sta;
open I,"< $dnds";
<I>;
while (<I>) {
    chomp;
    my @a=split(/\s+/);
    my $species=$a[2];
    my ($gene,$N,$S,$Nlen,$Slen)=($a[0],$a[7],$a[8],$a[3],$a[4]);
    next unless($species eq $fore || $species eq $back);
    $sum{$species}{N}+=$N;
    $sum{$species}{S}+=$S;
    if(exists $Gene2GoID{$gene}){
        foreach my $go(keys %{$Gene2GoID{$gene}}){
            my $count=$GO_count{$go};
            next if($count<10);
            $go_sta{$go}{$species}{N}+=$N;
            $go_sta{$go}{$species}{S}+=$S;
            $go_sta{$go}{$species}{Nlen}+=$Nlen;
            $go_sta{$go}{$species}{Slen}+=$Slen;
        }
    }
}
close I;

my $out="$0.out";
open R,"> $0.rscript";
print R "result=\"go\tN\tS\tfore_w\tfore_N\tfore_S\tback_w\tback_N\tback_S\tpvalue\"\n";
foreach my $go(sort keys %go_sta){
    my $fore_N=$go_sta{$go}{$fore}{N};
    my $fore_S=$go_sta{$go}{$fore}{S};
    my $back_N=$go_sta{$go}{$back}{N};
    my $back_S=$go_sta{$go}{$back}{S};
    my $fore_Nlen=$go_sta{$go}{$fore}{Nlen};
    my $fore_Slen=$go_sta{$go}{$fore}{Slen};
    my $back_Nlen=$go_sta{$go}{$back}{Nlen};
    my $back_Slen=$go_sta{$go}{$back}{Slen};

    my $fore_w=($fore_N/$fore_Nlen)/($fore_S/$fore_Slen);
    my $back_w=($back_N/$back_Nlen)/($back_S/$back_Slen);

    my $fore_sum_N=$sum{$fore}{N};
    my $fore_sum_S=$sum{$fore}{S};
    my $back_sum_N=$sum{$back}{N};
    my $back_sum_S=$sum{$back}{S};
	my $expected_percent=(($back_N/$back_sum_N)*$fore_sum_N)/( (($back_N/$back_sum_N)*$fore_sum_N) + (($back_S/$back_sum_S)*$fore_sum_S));
	#my $expected_percent=$back_N/($back_N+$back_S);
    # print O "$go\t$fore_N\t$fore_S\t$expected_percent\t$fore_w\t$back_w\n"; # $back_N\t$back_S\t$fore_sum_N\t$fore_sum_S\t$back_sum_N\t$back_sum_S\n";
    my $x=int($fore_N+0.5);
    my $n=int($fore_N+$fore_S+0.5);
    my $prefix="$go\t$fore_Nlen\t$fore_Slen\t$fore_w\t$fore_N\t$fore_S\t$back_w\t$back_N\t$back_S";
    print R '
test=binom.test('.$x.','.$n.',p='.$expected_percent.',alternative="greater")
line=paste("'.$prefix.'",test$p.value,sep="\t")
result=paste(result,line,sep="\n")
';
}
print R 'write.table(result,file="'.$out.'",,row.names=FALSE,col.names=FALSE,quote = FALSE)
';
close R;
