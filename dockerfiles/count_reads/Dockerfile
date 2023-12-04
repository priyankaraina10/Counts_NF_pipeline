# Use a minimal Python3 image as the base
FROM ubuntu

RUN apt-get update && apt-get install -y \
    python3 python3-pip

# Set the working directory
WORKDIR /app

# Copy your requirements.txt file and install dependencies
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy your script and any necessary files
COPY test_data/ /app/test_data/
COPY count_reads.py /app/
COPY conftest.py /app/
COPY test_count_reads.py /app/
RUN chmod +rx /app/test_count_reads.py
RUN chmod +rx /app/count_reads.py

# Set the command to run your tests
#CMD ["python3", "-m", "pytest", "test_count_reads.py"]
