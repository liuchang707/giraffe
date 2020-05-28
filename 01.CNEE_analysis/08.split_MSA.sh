cat maf-file.list | while read line;
do 
	echo "sh split.sh $line" ;
done > 09.run_split.sh
