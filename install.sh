#!/usr/bin/env bash
#
# Run this script once to install dependencies and configure Jupyter
#

set -euxo pipefail

# Change to the script directory
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Create a new Python venv
rm -rf server-env || true
python3 -m venv server-env
set +x
source server-env/bin/activate
set -x

# Install notebook Python dependencies
# wheel seems to need to be first (at lease for Python 3.6)
pip install wheel
# Pinning nbgrader version to avoid possible compatibility issues
# Newer jupyter version's have coroutine (jupyter-client 6.1.13, 6.2.0, and 7.0.6 (latest))
pip install nbgrader==0.6.2 docker jupyter-client==6.1.12 ansi2html==1.6.0

# Install the server Python dependencies
pip install -r jupyter_grade_server/requirements/production.txt
pip install --no-dependencies -e jupyter_grade_server

# Setup the Docker image (used for the sandboxed Jupyter kernel)
docker build --tag sandbox-python-kernel .
# Install Jupyter docker kernel
# dockernel is patched from https://github.com/MrMino/dockernel
pip install -e ./dockernel
yes| jupyter kernelspec uninstall -y sandbox-python-kernel || true
yes| dockernel install sandbox-python-kernel --name sandbox-python-kernel

# Only used for manually editing the source notebooks (edit-notebooks.sh)
# Install the nbgrader Jupyter extension needed to mark notebook cells as
# solutions or tests
jupyter nbextension install --sys-prefix --py nbgrader --overwrite
jupyter nbextension enable --sys-prefix --py nbgrader
jupyter serverextension enable --sys-prefix --py nbgrader

# Generate notebook and database files needed by the server
./regenerate-notebooks.py
