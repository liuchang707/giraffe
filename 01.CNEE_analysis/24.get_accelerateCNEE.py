#!/usr/env/python
import re
import sys
import os

inf=open(sys.argv[1])
length=sys.argv[2]
zscore=sys.argv[3]

name=[]
out={}
title=''
#count=0
for line in inf:
	if re.search('chr',line):
		title=line
		line=line.strip().split()
		for i in range(len(line)):
			name.append(line[i])
	else:
		l=line
		#count+=1
		#if count<=10:
		line=line.strip().split('\t')
		for i in range(4,len(line)):
			print(line[i])
			a=line[i].split(':')
			if int(a[0])>=int(length) and float(a[1])>=float(zscore):
				if name[i] not in out:
					out[name[i]]=l
				else:
					out[name[i]]+=l
for key in out:
	outf=open(key+'.'+length+'.'+zscore,'w')
	outf.write(title+out[key])
	outf.close()
inf.close()


		
	

