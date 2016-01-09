#!/usr/bin/python
#  -*- coding: utf-8 -*-
# Autor Aleksei Volkov
# Python test

from __future__ import print_function
from __future__ import unicode_literals

import re
import sys
import random
import string




# if there are enough params
if len(sys.argv) != 3:
    print("2 params needed")
    sys.exit(1)

# will generate random string of needed length
def randomword(length):
    return ''.join(random.choice(string.lowercase+string.uppercase+string.digits+"-"+"_") for _ in range(20))

# If the 1st file is readable
try:
    fh = open(sys.argv[1], 'r')
    fh1 = open(sys.argv[2], 'w')
    for line in fh.readlines():
        if not line.strip():
            continue
        if not line[0].isdigit():
            continue
        else:
            oneline = re.split(r'[\s\t]', line)
            output1=oneline[1][:1].lower()+oneline[2].lower()
            output2=oneline[1]+" "+oneline[2]
            output3=oneline[1].lower()+"."+oneline[2].lower()+"@itcollege.ee"
            output4=randomword(20)
            s = output1[:8]+","+output2+","+output3+","+output4
            fh1.write(s+"\n")

except IOError:
    print(sys.argv[1], " not readable")
fh.close()
fh1.close()



