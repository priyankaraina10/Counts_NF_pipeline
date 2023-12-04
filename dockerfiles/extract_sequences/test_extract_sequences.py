# test_extract_sequences.py

import os
import pytest
from extract_sequences import extract_sequences

def test_extract_sequences(test_data_path, tmp_path):
    # Prepare paths
    bam_file = os.path.join(test_data_path, "test.bam")
    bed_file = os.path.join(test_data_path, "test.bed")
    output_file = tmp_path / "output.fasta"

    # Run the function
    extract_sequences(bam_file, bed_file, output_file)

    # Check if the output file was created and is not empty
    assert output_file.exists()
    assert os.path.getsize(output_file) > 0

    # Add additional assertions based on the expected behavior of your function
    with open(output_file, "r") as output:
        content = output.read()
        assert "ACTAACACCCTTAATTCCATCCACCCTCCTCTCCCCAGGAGGCCTGCCCCCGCTAACCGGCTTTTTGCCCAAATGGGCCATTATCCAAGAATTCACAAAAA" in content
        assert "ATTCCATGCACCCTCCTCTCCCTAGGAGGCCTGCCCCCGCTAAGCGGCTTTTTGCCCAAATGGGCCATTATCGAAGAATTCACAAAAAAAAATATCCTCAT" in content
