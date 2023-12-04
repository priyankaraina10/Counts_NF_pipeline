
# test_extract_sequences.py

import os
import pytest
import json
from count_reads import count_reads

def test_count_reads(test_data_path, tmp_path):
    # Prepare paths
    bam_file = os.path.join(test_data_path, "test.bam")
    bed_file = os.path.join(test_data_path, "test.bed")
    output_file = tmp_path / "counts.json"

    # Run the function
    count_reads(bam_file, bed_file, output_file)

    # Check if the output file was created and is not empty
    assert output_file.exists()
    assert os.path.getsize(output_file) > 0

    # Add additional assertions based on the expected behavior of your function
    with open(output_file, "r") as output:
        counts_data = json.load(output)
    assert counts_data["chrM_5000_6500"] == 4258
