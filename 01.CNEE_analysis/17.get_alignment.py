#!/usr/env/python

import re
import sys
import os

out=open('02.get_alignment.sh','w')
for i in range(1,30):
	out.write('/public/home/liuchang/scripts/ucsc_tools/mafsInRegion ELEMENTS/goat.'+str(i)+'.noGiraffe.sing.maf.bed.new.bed split_maf/goat.'+str(i)+'.gerenuk.sing.bed.maf split_maf/goat.'+str(i)+'.gerenuk.sing.maf\n')

out.close()
