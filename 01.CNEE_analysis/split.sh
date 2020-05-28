maf=$1

file=${maf##*/}
mkdir -p $maf.split/$file
./bin/msa_split $maf --in-format MAF  --windows 1000000,0 --out-root $maf.split/$file/$file --out-format SS --min-informative 1000 --between-blocks 5000 
