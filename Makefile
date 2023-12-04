.PHONY: all install_nextflow build_dockers test_dockers run_workflow clean

# Define variables
NEXTFLOW_VERSION := 20.10.0
DOCKERFILES_FOLDER := dockerfiles
DOCKER_IMAGE_NAME1 := countreads
DOCKER_IMAGE_NAME2 := extractsequences
PARAMS_FILE ?= params.yaml

# Target 1: Install Nextflow
install_nextflow:
	curl -s https://get.nextflow.io | bash
	mv nextflow /usr/local/bin/

# Target 2: Build and test Docker images
build_dockers:
	echo "Building Docker Image: $(DOCKER_IMAGE_NAME1)"
	cd $(DOCKERFILES_FOLDER)/count_reads && docker build -t $(DOCKER_IMAGE_NAME1) .
	echo "Building Docker Image: $(DOCKER_IMAGE_NAME2)"
	cd $(DOCKERFILES_FOLDER)/extract_sequences && docker build -t $(DOCKER_IMAGE_NAME2) .

test_dockers:
	echo "Running Tests for Docker Image: $(DOCKER_IMAGE_NAME1)"
	docker run -it $(DOCKER_IMAGE_NAME1) pytest
	sleep 5
	echo "Building Docker Image: $(DOCKER_IMAGE_NAME2)"
	docker run -it $(DOCKER_IMAGE_NAME2) pytest

# Target 3: Run Nextflow workflow
run_workflow:
	nextflow run main.nf -params-file $(PARAMS_FILE) -profile docker

# Target 4: Clean run artifacts
clean:
	rm -rf work .nextflow*

clean_all:
	rm -rf results


# Target for all (default target)
all: install_nextflow build_dockers test_dockers run_workflow

# Help target
help:
	@echo "Available targets:"
	@echo "  - install_nextflow : Install Nextflow"
	@echo "  - build_dockers    : Build the Docker images"
	@echo "  - test_dockers     : Test the Docker images"
	@echo "  - run_workflow     : Run Nextflow workflow"
	@echo "  - clean            : Clean run artifacts"
	@echo "  - all              : Install Nextflow, build/test Docker images, and run workflow (default)"
