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
	cell_id=`echo $file | sed 's/.*\///' | sed 's/_.*//g'`
	#~ pair=R1
	if echo $file | grep "R1" 
	then
		pair="R1"
	else
		pair="R2"
	fi
	twin_file=`find $twin_dir -name $cell_id"_*"$pair"_*"`
	merge=$cell_id"_"$pair"_merged.fastq.gz"
	echo $file $cell_id $twin_file $merge $pair
	cat $file $twin_file > $merge 
done
