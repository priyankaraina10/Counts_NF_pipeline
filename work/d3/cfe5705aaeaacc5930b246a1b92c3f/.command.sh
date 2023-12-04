#!/bin/bash -ue
samtools sort -o sorted_bam.bam mt.bam
samtools index sorted_bam.bam
