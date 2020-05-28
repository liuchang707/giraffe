mkdir ELEMENTS; 
mkdir SCORES;
cat maf-file.list | while read line; 
do 
	file=${line##*/}
	echo "./bin/phastCons --most-conserved ELEMENTS/${file}.bed --score $line ave.cons.mod,ave.noncons.mod > SCORES/${file}.wig ";
done >  16.run_phastCons.sh

#### run add_maf_header.sh before 16.run_phastCons.sh if your files do not have header ;

