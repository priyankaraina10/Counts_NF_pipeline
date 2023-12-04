
## Project

### Inputs

#### BAM

Input BAM can be obtained at [Tiny Bam](https://github.com/brainstorm/tiny-test-data/blob/master/wgs/mt.bam).

#### BED

BED file is located in `input/regions.bed.gz`.,M

### Output

Using [Nextflow](https://www.nextflow.io/) 

1. Read counts for the regions specified in the provided BED file outputed as JSON.
2. Extract reads in the regions and convert it into a FASTA file where each entry consists of:
    ```
    >{READ_ID} 
    {READ_SEQUENCE}
    ```