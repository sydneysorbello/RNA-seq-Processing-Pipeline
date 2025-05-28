#!/usr/bin/env python3

import argparse
# here we are initializing the argparse object that we will modify
parser = argparse.ArgumentParser()
# we are asking argparse to require a -i or -input flag on the command line when this
# script is invoked. It will store it in the "filenames" attribute of the object
# we will be passing it via snakemake, a list of all the outputs of verse so we can
# concatenate them into a single matrix using pandas
parser.add_argument("-i", "--input", help='a GFF file', dest="input", required=True)
parser.add_argument("-o", "--output", help='Output file with region' , dest="output", required=True)
# this method will run the parser and input the data into the namespace object
args = parser.parse_args ()
# regex solution with dictionary
import re
id_2_name = {}

genename = r'gene_name\s([^;]*)'
geneid = r'gene_id\s([^;]*)'

with open(args.input, 'r') as r:
    for line in r:
        if line.startswith('#'):
            continue
        gene_name = re.search(genename,line)
        gene_id = re.search(geneid, line)
        
        if gene_id.group().split('"')[1] in id_2_name:
            continue
        else:
            id_2_name[gene_id.group().split('"') [1]] = gene_name.group().split('"')[1]

with open(args.output, 'wt') as w:
    for k,v in id_2_name.items():
        w.write('{}\t{}\n'.format(k,v))