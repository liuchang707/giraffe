#! /usr/bin/env perl
use strict;
use warnings;

# my $geneid="ENSGACT00000022344";
my $geneid=shift;
my $gff_file="/bak3/liuchang/project/giraffe/11.geneloss/02.search_lost_gene/giraffe/Bos_taurus.UMD3.1.87.gff3.check.gff";
my $bamlst="/bak3/liuchang/project/giraffe/11.geneloss/03.search_lost_gene.Giraffe/scripts/bam.lst";
my @ind=("xaa","xab","xac","xad","ST-1.1","ST-1.2","ST-1.3","ST-2.1","ST-2.2"); # must be the individual in the bamlst

###########################################################

`grep $geneid $gff_file | grep CDS > $geneid.gff`;

if(-z "$geneid.gff"){
    die "$geneid is empty\n";
}

my $mRNA=`grep $geneid $gff_file | grep mRNA`;
my @a=split(/\s+/,$mRNA);
my ($chr,$start,$end)=($a[0],$a[3],$a[4]);
my $command="samtools depth -a -r $chr:$start-$end -f $bamlst > $geneid.depth";
`$command`;

my $depth="$geneid.depth";
my $gff="$geneid.gff";
my $out="$geneid.out";
my %pos;
open I,"< $gff";
my $strand="+";
while (<I>) {
    my @a=split(/\s+/);
    my ($start,$end,$strand)=($a[3],$a[4],$a[6]);
    if($strand eq "-"){
        $strand="-";
    }
    for(my $i=$start;$i<=$end;$i++){
        $pos{$i}=1;
    }
}
close I;
my %hash;
my $cds_pos=0;
if($strand eq "+"){
    foreach my $i(sort {$a<=>$b} keys %pos){
        $cds_pos++;
        $hash{$i}=$cds_pos;
    }
}
elsif($strand eq "-"){
    foreach my $i(sort {$b<=>$a} keys %pos){
        $cds_pos++;
        $hash{$i}=$cds_pos;
    }
}

open O,"> $out";
open I,"< $depth";
print O "pos\tind\tdepth\n";
while (<I>) {
    chomp;
    my @a=split(/\s+/);
    shift @a;
    my $i=shift @a;
    next unless(exists $hash{$i});
    my $cds_pos=$hash{$i};
    for(my $j=0;$j<@a;$j++){
        my $ind=$ind[$j];
        my $depth_ind=$a[$j];
        print O "$cds_pos\t$ind\t$depth_ind\n";
    }
}
close I;
close O;

open R,"> $geneid.plot.R";
print R '
library("ggplot2")
a=read.table("'.$out.'",header=T)
pdf("'.$geneid.'.pdf",width=5,height=3);
ggplot(a,aes(pos,depth,color=ind))+geom_line()+scale_color_manual(values=c("#025a8d","#2e8cbd","#a7bcda","#58955c","#BBFFFF","#B22222","#9B30FF","#FF6EB4","#EEEE00"))+labs(x="'.$geneid.'")
dev.off();
';
close R;
`Rscript $geneid.plot.R`;
