import pysam
import json
import argparse
def count_reads(bam_file, bed_file, output_json):
    # Open BAM file
    bam = pysam.AlignmentFile(bam_file, "rb")

    # Read BED file
    with open(bed_file, "r") as bed:
        counts = {}

        for line in bed:
            # Parse BED file
            chrom, start, end = line.strip().split('\t')
            start, end = int(start), int(end)

            # Count reads within the specified region
            count = bam.count(chrom, start, end)
            
            # Store count in dictionary
            counts[f"{chrom}_{start}_{end}"] = count

    # Close BAM file
    bam.close()

    # Write counts to JSON file
    with open(output_json, "w") as json_file:
        json.dump(counts, json_file, indent=2)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Extract sequences from BAM file based on BED regions.")
    parser.add_argument("--bam_file", required=True, help="Input BAM file path")
    parser.add_argument("--bed_file", required=True, help="Input BED file path")
    parser.add_argument("--output_json", required=True, help="Output file path for counts")
    
    args = parser.parse_args()

    # Call the extract_sequences function with command line arguments
    count_reads(args.bam_file, args.bed_file, args.output_json)