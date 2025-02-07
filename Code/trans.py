#!/usr/bin/python

import sys

f= sys.argv[1]

ts = ["A_G", "G_A", "C_T", "T_C"]
tv = ["A_C", "C_A", "A_T", "T_A", "C_G", "G_C", "G_T","T_G"]


cnt_ts = 0
cnt_tv = 0

with open(f, 'r') as fr:
        for line in fr:
                if line.startswith("#"):
                        pass
                else:
                        l = line.strip().split("\t")
                        ref = l[3]
                        alt = l[4]
                        change = ref+"_"+alt

                        if change in ts:
                            cnt_ts += 1
                        elif change in tv:
                            cnt_tv += 1

print("transition: ",cnt_ts)
print("transversion: ",cnt_tv)
print("ts/tv: ",float(cnt_ts/cnt_tv))

