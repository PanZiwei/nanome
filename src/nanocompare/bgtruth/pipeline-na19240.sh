#!/bin/bash
#Params:
# -c        config file for input
# -o        output folder
# -gBis     Bismark reference file
# -gBwa     reference genome for BWA-meth
# --test    output only script, but not submit to helix

# Currently, only Bismark success, the BWA is always failed.

set -x

out_dir=/projects/li-lab/yang/results/2020-12-21/na19240-results
config_fn=configFile-NA19240.tsv

bismark_reference=/projects/li-lab/yang/workspace/nano-compare/data/reference/hg38/Homo_sapiens/UCSC/hg38/Sequence/WholeGenomeFasta/
bwameth_reference=/projects/li-lab/yang/workspace/nano-compare/data/reference/hg38/hg38.fa
# /projects/li-lab/yang/workspace/nano-compare/data/reference/hg38/bwaMeth/hg38.fa

if_only_script=--test
if_only_script=

python BS_Seq_Pipeline.py -o ${out_dir} -c ${config_fn} -dt rrbs -g hg38 -gBis ${bismark_reference} -gBwa ${bwameth_reference} ${if_only_script}