import pysam
import json
import argparse
def extract_sequences(bam_file, bed_file, output_file):
    # Open BAM file
    bam = pysam.AlignmentFile(bam_file, "rb")

    # Read BED file
    with open(bed_file, "r") as bed:
        # Open output file for writing sequences
        with open(output_file, "w") as output:
            for line in bed:
                # Parse BED file
                chrom, start, end = line.strip().split('\t')
                start, end = int(start), int(end)

                # Fetch sequences within the specified region
                for read in bam.fetch(chrom, start, end):
                    output.write(f">{read.query_name}\n    {read.query_sequence}\n")

    # Close BAM file
    bam.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract sequences from BAM file based on BED regions.")
    parser.add_argument("--bam_file", required=True, help="Input BAM file path")
    parser.add_argument("--bed_file", required=True, help="Input BED file path")
    parser.add_argument("--output_file", required=True, help="Output file path for sequences")
    
    args = parser.parse_args()

    # Call the extract_sequences function with command line arguments
    extract_sequences(args.bam_file, args.bed_file, args.output_file)