# Docker Usage Guide for masscube

This document explains how to use the containerized version of masscube for LC-MS data processing.

## Building the Docker Image

```bash
# Build the image
docker build -t masscube .

# Or using Docker Compose
docker compose build
```

## Basic Usage

### Running the Default Container
```bash
# Show container info and available commands
docker run --rm masscube
```

### Running Specific Commands

Mount your data directory to `/data` in the container and run masscube commands:

```bash
# Example: Generate sample table for mzML/mzXML files in ./data directory
docker run --rm -v $(pwd):/data masscube generate-sample-table

# Example: Run untargeted metabolomics workflow
docker run --rm -v $(pwd):/data masscube untargeted-metabolomics

# Example: Batch processing
docker run --rm -v $(pwd):/data masscube batch-processing

# Example: Find outliers
docker run --rm -v $(pwd):/data masscube find-outliers

# Example: Build classifier
docker run --rm -v $(pwd):/data masscube build-classifier
```

### Interactive Usage with Docker Compose

```bash
# Start an interactive container with bash access
docker compose run masscube

# Or run specific commands
docker compose run masscube-cmd untargeted-metabolomics
```

## Data Directory Structure

The masscube tools expect your data to be organized as follows:

```
your-project-directory/
├── data/                    # Input LC-MS files (.mzML, .mzXML)
│   ├── sample1.mzML
│   ├── sample2.mzML
│   └── ...
├── sample_table.csv         # Generated/manual sample metadata
└── output/                  # Processing results (created automatically)
```

## Volume Mounting Examples

### Process data in current directory:
```bash
docker run --rm -v $(pwd):/data masscube generate-sample-table
```

### Process data in specific directory:
```bash
docker run --rm -v /path/to/your/data:/data masscube untargeted-metabolomics
```

### Windows users:
```cmd
docker run --rm -v %cd%:/data masscube generate-sample-table
```

## Available CLI Commands

- `untargeted-metabolomics`: Complete untargeted metabolomics workflow
- `batch-processing`: Process multiple files in batch
- `generate-sample-table`: Generate sample metadata table from data files  
- `find-outliers`: Quality control and outlier detection
- `build-classifier`: Build feature classification models

## Troubleshooting

1. **Permission issues**: Make sure your data directory is readable by the container
2. **File not found errors**: Ensure your data files are in the correct location (./data/ subdirectory)
3. **Mount path issues**: Use absolute paths when mounting volumes

## Python API Access

You can also use the Python API directly in the container:

```bash
docker run --rm -it -v $(pwd):/data masscube python
```

Then in Python:
```python
import masscube
# Use masscube Python API
```