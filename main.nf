#!/usr/bin/env nextflow

nextflow.enable.dsl=2

// Load parameters from the config file
params.bam_file = params.bam_file
params.bed_file = params.bed_file
params.output_sequences = params.output_sequences
params.output_counts = params.output_counts

// Process to sort and index the BAM file
process sort_and_index_bam {
    container "quay.io/biocontainers/samtools:1.18--h50ea8bc_1"
    input:
    path(bam_file)

    output:
    path("*sorted_bam.bam"), emit: sorted_bam
    path("*sorted_bam.bam.bai"), emit: sorted_bam_index

    script:
    """
    samtools sort -o sorted_bam.bam ${bam_file}
    samtools index sorted_bam.bam
    """
}

// Process to extract sequences
process extract_sequences {
    container "extractsequences:latest"
    publishDir "${params.outdir}", mode: "copy"

    input:
    file(sorted_bam)
    file(sorted_bam_index)
    path(bed)

    output:
    path("*.fasta"), emit: output_sequences

    script:
    """
    python3 /app/extract_sequences.py \\
        --bam_file ${sorted_bam} \\
        --bed_file ${bed} \\
        --output_file ${params.output_sequences}
    """
}

// Process to count reads
process count_reads {
    container "countreads:latest"
    publishDir "${params.outdir}", mode: "copy"

    input:
    file(sorted_bam)
    file(sorted_bam_index)
    path(bed)

    output:
    path("*.json"), emit: output_counts

    script:
    """
    python3 /app/count_reads.py \\
        --bam_file ${sorted_bam} \\
        --bed_file ${bed} \\
        --output_json ${params.output_counts}
    """
}

// Execute the workflow
workflow {
    // Sort and index the BAM file first
    sort_and_index_bam(params.bam_file)

    // Use the emitted sorted BAM file for subsequent processes
    extract_sequences(sort_and_index_bam.out.sorted_bam,sort_and_index_bam.out.sorted_bam_index, params.bed_file)
    count_reads(sort_and_index_bam.out.sorted_bam,sort_and_index_bam.out.sorted_bam_index, params.bed_file)
}

