mod=''
for i in `ls 4d_sites/*.mod`;
do
	mod="$i ,$mod"
done 
echo $mod 
./bin/phyloBoot --read-mods $mod  --output-average ave.noncons.mod
