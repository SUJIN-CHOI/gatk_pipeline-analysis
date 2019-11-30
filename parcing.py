#!/usr/bin/python

import sys

f = sys.argv[1]
cnt = 0


gene_dic = {}


with open(f, 'r') as fr:
    for line in fr:
                if line.startswith("#"):
                        pass
                else:
                        cnt += 1
                        l = line.strip().split("\t")[7].split("|")
                        #print(1[#]) #RNR1
                        #sys.exit()


                        gene = 1[3]
                        if gene in gene_dic:
                            gene_dic[gene] += 1
                        else:
                            gene_dic[gene] =1

#print(gene_dic)
for k, v in gene_dic.items():
    if v >= 10:
        print(k,v)
print("line number: ", cnt)
