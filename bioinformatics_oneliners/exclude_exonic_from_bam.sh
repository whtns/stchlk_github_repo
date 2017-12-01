#!/bash
#~ exclude exonic from bam

unfilt_bam=$1
exonic_bed=$2

intronic_bam=`echo $i | sed 's/.bam/_intronic.bam/'`

bedtools intersect -wa -abam $unfilt_bam -b $exonic_bed -v > $intronic_bam
