for i in `ls *.4.1.5`;do cat $i| awk -F '\t' '{print $1"\t"$2"\t"$3"\t0\t0"}' >$i.bed.annoformat;done
