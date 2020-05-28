cat maf-file.list | while read line; 
do
	file=${line##*/}
	echo "cd /public/home/liuchang/projects/giraffe/01.HCE ;./bin/msa_view 4d_sites/${file}.codon.ss  --in-format SS --out-format FASTA  --tuple-size 1 > 4d_sites/${file}.sites.fa";done > ss2fa.sh
sh ss2fa.sh
