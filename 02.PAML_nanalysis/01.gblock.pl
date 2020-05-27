use strict;
use warnings;

## created by Yongzhi Yang. 2017/3/20 ##

my $Gblocks="Gblocks_0.91b/Gblocks";
my $tools="scripts/Gblocks2Paml.pl";
open (F,">Gblocks.sh");
my @in=<align/*/cds.best.fas>;
for my $in (@in){
    my $out=$in;
	if ($out=~/.*\/(.*)\/.*/){
	#my$name='';
	#$name=$1;
	$out=~s/cds.best.fas$/cds.paml/;
	print F"cd paml;$Gblocks $in -t=c ; perl $tools $in-gb $out\n";
    }
}

