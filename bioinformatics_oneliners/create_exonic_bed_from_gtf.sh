#!/bin/bash
#~ create exonic bed from gtf file

in_gtf=$1

out_bed=`echo $in_gtf | sed 's/.gtf/_exonic.bed/'`

awk '$3 == "exon"' $in_gtf | convert2bed --input=gtf - > $out_bed
