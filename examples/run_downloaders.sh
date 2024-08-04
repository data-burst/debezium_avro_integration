#!/bin/bash

# Check if the example directory name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <example_directory_name>"
  exit 1
fi

EXAMPLE_DIR=$1

# Navigate to the root of the project
ROOT_DIR=$(git rev-parse --show-toplevel)
cd $ROOT_DIR

# Run the first downloader script
bash scripts/downloader.sh

# Check if the first script executed successfully
if [ $? -ne 0 ]; then
  echo "Error: scripts/downloader.sh failed"
  exit 1
fi

# Run the second downloader script
bash examples/$EXAMPLE_DIR/scripts/jarfile_downloader.sh

# Check if the second script executed successfully
if [ $? -ne 0 ]; then
  echo "Error: examples/$EXAMPLE_DIR/scripts/jarfile_downloader.sh failed"
  exit 1
fi

echo "Both scripts executed successfully"
