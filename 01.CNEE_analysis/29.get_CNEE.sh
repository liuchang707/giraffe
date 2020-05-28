for i in `ls *.function.list`|do cat $i|grep -v '^exonic' >$i.CNEE.list
