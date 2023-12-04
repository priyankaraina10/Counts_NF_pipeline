# Use a minimal Python3 image as the base
FROM ubuntu

RUN apt-get update && apt-get install -y \
    python3 python3-pip
# Set the working directory
WORKDIR /app

# Copy your requirements.txt file and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy your script and any necessary files
COPY test_data/ /app/test_data/
COPY extract_sequences.py /app/
COPY conftest.py /app/
COPY test_extract_sequences.py /app/
RUN chmod +rx /app/extract_sequences.py
RUN chmod +rx /app/test_extract_sequences.py


# Set the command to run your tests
#CMD ["python3", "-m", "pytest", "test_extract_sequences.py"]
