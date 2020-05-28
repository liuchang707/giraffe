cat maf-file.list | while read line; 
do 
	file=${line##*/}
	echo "./bin/phyloFit  --tree \"(SpermWhale,(TragulusNew,((Pronghorn,((Giraffe,Giraffe3),Okapi)),((Reindeer,Daviddeer),(ForestMuskDeer10x,(goat,Cattle))))));\" --msa-format FASTA  --out-root  4d_sites/${file}.nonconserved-4d 4d_sites/${file}.sites.fa" ;
done > 06.estimate_parameter.sh
