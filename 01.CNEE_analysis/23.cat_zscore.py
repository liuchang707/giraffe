#!/usr/env/python
import re
import sys
import os
#inf=open(sys.argv[1])

#os.system('rm 23.all.zscore')
out=open('23.allruminant.zscore','a')

out.write('chr\tpos_start\tpos_end\tlength\tCattle\tForestMuskDeer\tGerenuk\tGiraffe\tIbex\tOkapi\tPronghorn\tReindeer\tSpringbuck\tWhiteTailedDeer\tYak\tgoat\n')
	
for f in os.popen('ls /home/liuchang/project/giraffe/14.HCE/analysisfromRuminantProject/splitmaf/goat.*.sing.bed.maf.allruminant.diff.align.zscore'):
	inf=open(f.strip())
	chrname=f.split('/')[-1].split('.')[1]
	for line in inf:
		if not re.search('pos',line):
			line=line.strip().split()
			if int(line[1])>=50:
				out.write(chrname+'\t'+line[0].split('_')[0]+'\t'+line[0].split('_')[1]+'\t')
				aa="\t".join(line[1:])
				out.write(aa+'\n')
	inf.close()
out.close()
