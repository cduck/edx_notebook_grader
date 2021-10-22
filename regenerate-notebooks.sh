#!/usr/bin/env bash
#
# Run this script after editing the lab notebooks (the notebooks under the
# 'source' directory).  This generates release notebooks in the 'release'
# directory and the gradebook.db template database.
#
# Both the release notebooks and gradebook.db are used by the grade server
# during auto grading.  The release notebooks should be given out to  students
# (as a downloadable file on EdX).  The students will then edit and submit this
# file.
#
# Do not run while run-server.sh is running!
#

set -euxo pipefail

# Change to the script directory
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Activate the Python venv
set +x
source server-env/bin/activate
set -x

# Run the script
python regenerate-notebooks.py
