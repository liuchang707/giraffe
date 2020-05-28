cat maf-file.list | while read line; 
do
	file=${line##*/}
	echo "cd $line.split/$file; ls *.ss | while read ss; do /public/home/liuchang/projects/giraffe/01.HCE/bin/phastCons --estimate-rho \$ss --no-post-probs \$ss /public/home/liuchang/projects/giraffe/01.HCE/ave.noncons.mod; done ;cd - ";
done > 11.get_conserved_model.sh
