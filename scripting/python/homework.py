#!/usr/bin/python
#  -*- coding: utf-8 -*-
# Autor Aleksei Volkov
# Python homework

from __future__ import print_function
from __future__ import unicode_literals

import re
import sys
import urllib2


# if there are enough params
if len(sys.argv) != 3:
    print("2 params needed")
    sys.exit(1)

# If the 1st file is readable
try:
    fh = open(sys.argv[1], 'r')
    for line in fh.readlines():
        oneline = line.split(',')
        print("URL:", oneline[0], "String:", oneline[1])
        try:
            response = urllib2.urlopen(oneline[0])
            html = response.read()
            strings = re.findall(oneline[1], html)
            if not strings:
                newstr = oneline[0]+","+oneline[1]+","+"no"
            else:
                newstr = oneline[0]+","+oneline[1]+","+"yes"
        except Exception:
            print("can't open given URL")

except IOError:
    print(sys.argv[1], " not readable")
fh.close()

# if 2nd file is writable
try:
    fh = open(sys.argv[2], 'w')
    fh.write(newstr)
except IOError:
    print(sys.argv[2], " not writable")
fh.close()

