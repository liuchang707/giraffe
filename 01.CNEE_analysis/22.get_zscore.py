#!/usr/env/python

import  math
import os
import re
import sys
#import numpy

inf1=open(sys.argv[1])
inf2=open(sys.argv[2])#species list
out=open(sys.argv[1]+'.zscore','w')
sp={}
for line in inf2:
	line=line.strip().split()
	sp[line[0]]=1

out.write('pos\tlength')
for key in sorted(sp.keys()):
	out.write('\t'+key)
out.write('\n')
	

for line in inf1:
	line=line.strip().split('\t')
	#if int(line[6].strip().split(' ')[1])>=4:##at least springbuck have 4 niq sites
	nlist=[]
	for i in range(2,len(line)):
		num=line[i].strip().split(' ')[1]
		if num !='NA':
			nlist.append(num)
	sum1=0
	for i in nlist:
		sum1+=int(i)
	#print (line[0]+'\t'+line[1])
	avg1=float(sum1)/float(len(nlist))
	varsum=0
	for i in nlist:
		varsum+=(int(i)-avg1)**2
	avg2=float(varsum/len(nlist))
	std=math.sqrt(avg2)
	out.write(line[0]+'\t'+line[1])
	for i in range(2,len(line)):
		num=line[i].strip().split(' ')[1]
		if num == 'NA':
			out.write('\tNA:NA')
		else:
			if std!=0:
				out.write('\t'+str(num)+':'+str((int(num)-avg1)/std))
			else:
				out.write('\t'+str(num)+':NO')
	out.write('\n')
