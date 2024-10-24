#!/bin/bash
set -e

# Sync APT repository
sudo apt-get update
sudo apt-get install -y --no-install-recommends unzip

curl -o /tmp/miniconda.sh -O  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x /tmp/miniconda.sh

# Install system-wide (but not good permissions to ~/conda..?):
# sudo /tmp/miniconda.sh -b -p ~/conda
# Alternatively install locally:
/tmp/miniconda.sh -b -p ~/conda

# Run as user (modifies .bashrc, adding conda to path)
~/conda/bin/conda init bash

# Update base conda environment
~/conda/bin/conda update -n base -c defaults conda

# Create conda environment
~/conda/bin/conda env create -f ~/Project_DML/conda-environment-gpu-unix.yml

# Create jupyter notebook config file (overwrite if exists)
mkdir -p ~/.jupyter
echo "c.NotebookApp.ip = '*'">~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False">>~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888">>~/.jupyter/jupyter_notebook_config.py
