#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'need to provide additional arguments:
 	file_pattern=$1
	input_dir=$2
	twin_dir=$3'
    exit 0
fi

file_pattern=$1
input_dir=$2
twin_dir=$3

for file in `find $input_dir -name $file_pattern`;do 
	cell_id=`echo $file | sed 's/.*\///' | sed 's/\..*//g'`
	twin_file=`find $twin_dir$cell_id"/hisat2" -name $cell_id".bam"`
	merge=$cell_id"_merged.bam"
	echo $file $cell_id $twin_file $merge 
	java -jar /usr/share/java/picard-2.11.0.jar MergeSamFiles I=$file I=$twin_file O=$merge
done
