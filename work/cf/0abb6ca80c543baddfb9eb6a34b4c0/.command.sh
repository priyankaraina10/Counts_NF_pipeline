#!/bin/bash -ue
python3 /app/count_reads.py \
    --bam_file sorted_bam.bam \
    --bed_file regions.bed \
    --output_json counts.json
