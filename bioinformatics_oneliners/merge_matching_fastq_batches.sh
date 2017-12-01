#!/bin/bash

file_pattern=$1
input_dir=$2
twin_dir=$3

for i in `find $input_dir -name $file_pattern`;do 
	j=`echo $i | sed 's/_001.*//'`
	l=`find $twin_dir -name $j`
	m=$j_merged.fastq.gz
	echo $i $j $m
	cat $i $l > $m 
done
