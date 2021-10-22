#!/usr/bin/env bash
#
# This script runs the grade server.  It must always be running.  Otherwise when
# students submit on EdX, they will not receive immediate feedback or a grade.
#
# Do not run while regenerate-notebooks.sh is running!
#

set -euxo pipefail

# Change to the script directory
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Activate the Python venv
set +x
source server-env/bin/activate
set -x

# Start the grade server from this directory
cd grader-root

# Run the server
python -m jupyter_grade_server -d .
