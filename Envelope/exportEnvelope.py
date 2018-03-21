import sys
import re
import csv
import struct

# taken from https://stackoverflow.com/questions/23624212/how-to-convert-a-float-into-hex
def float_to_hex(f):
    return hex(struct.unpack('<I', struct.pack('<f', f))[0])

# verifies that the user pass the right number of arguments
if(len(sys.argv) < 2):
  print('You must run this with 1 arguments!\n1. The tsv file\n')
  sys.exit(0)

#retrive user arguments
tsvFile = sys.argv[1]

exportFile = open('exportedEnvelope.txt','w') 

numbers = []
# this csv reader will read line by line, while splitting on the tab delimiter
with open(tsvFile,'rt') as tsvin:
	tsvin = csv.reader(tsvin, delimiter='\t')
	# goes through each line in the file
	for row in tsvin:
		for number in row:
			dec = float(number)
			numbers.append(float_to_hex(dec))
i = 0		
for number in numbers:
	if(i % 8 == 0):
		exportFile.write('\n')
	i = i + 1	
	exportFile.write('X\"%s\", ' % number)
	
	

