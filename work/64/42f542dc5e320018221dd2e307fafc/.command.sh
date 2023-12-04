#!/bin/bash -ue
python3 /app/extract_sequences.py \
    --bam_file sorted_bam.bam \
    --bed_file regions.bed \
    --output_file sequence.fasta
