#!/usr/env/python 

import re
import sys
import os

inf1=open(sys.argv[1])
inf2=open('species')
inf3=open('wantspecies')
out=open(sys.argv[1]+'.allruminant.diff','w')

dic={}
d={}
sp={}
for line in inf2:
	line=line.strip().split()
	sp[line[0]]=1

want={}
for line in inf3:
	line=line.strip().split()
	want[line[0]]=1

pos=''
for line in inf1:
	if re.search('^s',line):
		line=line.strip().split()
		if line[1].split('.')[0]=="goat":
			pos=line[2]+'_'+str(int(line[2])+int(line[3])-1)
			dic[line[1].split('.')[0]]=line[6].upper()
			d[line[1].split('.')[0]]=1
		elif line[1].split('.')[0] in sp:
			dic[line[1].split('.')[0]]=line[6].upper()
			if line[1].split('.')[0] in want:
				d[line[1].split('.')[0]]=1
	elif re.search('^$',line):##match Blank line
		if  len(dic)>=30 and len(d)==len(want) : ## all is there
			#print('yes')
			length=len(dic['goat'])
			count={}
			for key in sp:
				if key not in dic:
					count[key]='NA'
				else:
					count[key]=0
			for i in range(length):
				site={}
				#diff={}
				for key in sp:
					#print(key)
					if key in dic:
						if dic[key][i] not in site:
							site[dic[key][i]]=[]
							site[dic[key][i]].append(key)
						else:
							site[dic[key][i]].append(key)
						#print site[dic[key][i]]
				#print len(site)
				if len(site)==2:
					#print('yes')
					for s in site:
						#if len(site[s])==1 and 'Okapi' not in site[s]:
						if len(site[s])==1:
							if site[s][0] not in count:
								count[site[s][0]]=1
							else:
								count[site[s][0]]+=1
						#if len(site[s])==1 and 'Okapi' in site[s]:
						#	if 'Okapi' not in count:
						#		count['Okapi']=1
						#	else:
						#		count['Okapi']+=1
			out.write(pos+'\t'+str(length))
			for c in sorted(count.keys()):
				if c in want:
					if count[c]=='NA':
						out.write('\t'+c+': NA')
					else:
						out.write('\t'+c+': '+str(count[c]))
			out.write('\n')
			#exit('test finished')
		dic={}
		d={}

