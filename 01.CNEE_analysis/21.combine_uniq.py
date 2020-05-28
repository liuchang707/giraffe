#!/usr/env/python

import re
import sys
import os

inf=open(sys.argv[1])
out=open(sys.argv[1]+'.align','w')

dic={}
ha={}
for line in inf:
	l=line
	dic[line.split()[0].split('_')[0]]=l
	ha[int(line.split()[0].split('_')[0])]=line.split()[0].split('_')[1]

com=[]
root=0
for key in sorted(ha.keys()):
	if key==root+1:
		com.append(key)
	else:
		if len(com)>0:
			print (str(com[0])+'\t'+str(len(com))+'\n')
			out.write(str(com[0])+'_'+ha[com[-1]]+'\t'+str(int(ha[com[-1]])-com[0]+1))
			sp={}
			for k in com:
				l=dic[str(k)].strip().split('\t')
				for i in range(2,len(l)):
					if l[i].split()[0] not in sp:
						if l[i].split()[1] !='NA':
							sp[l[i].split()[0]]=int(l[i].split()[1])
						else:
							sp[l[i].split()[0]]=0
					else:
						if l[i].split()[1] !='NA':
							sp[l[i].split()[0]]+=int(l[i].split()[1])
			for s in sorted(sp.keys()):
				out.write('\t'+s+' '+str(sp[s]))
			out.write('\n')
		####################
		root=int(ha[key])
		com=[]
		com.append(key)

if len(com)>0:
	#print(str(key)+'\t'+str(len(com))+'\n')
	out.write(str(com[0])+'_'+ha[com[-1]]+'\t'+str(int(ha[com[-1]])-com[0]+1))
	sp={}
	for k in com:
		l=dic[str(k)].strip().split('\t')
		for i in range(2,len(l)):
			if l[i].split()[0] not in sp:
				if l[i].split()[1] !='NA':
					sp[l[i].split()[0]]=int(l[i].split()[1])
				else:
					sp[l[i].split()[0]]=0
			else:
				if l[i].split()[1] !='NA':
					sp[l[i].split()[0]]+=int(l[i].split()[1])
	for s in sorted(sp.keys()):
		out.write('\t'+s+' '+str(sp[s]))
	out.write('\n')

	
out.close()
inf.close()
