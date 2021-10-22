#!/usr/bin/env bash

echo =============================================================================
echo
echo Run this script to edit or add new assignments.
echo
echo 1. Run this script.  Jupyter is launched with the configuration needed to
echo     edit nbgrader notebooks.
echo 2. Start an SSH tunnel from your local computer (to connect to Jupyter).
echo     $ ssh -L 9999:localhost:8888 "$(whoami)@$(hostname -f)"
echo 3. Find and copy the output line below that says
echo     http://localhost:8888/?token=...
echo 4. In a broswer:
echo     a. Open this link but replace 8888 with 9999.
echo     b. Edit the notebooks under the source/ directory.
echo     c. While editing, make sure to use sandbox-python-kernel, not the
echo         python3 kernel.
echo     d. Use the Formgrader tab to generate and preview the release version.
echo 5. Quit this script (Ctrl+C, Ctrl+C)
echo 6. Git commit and push your changes to the source notebooks.
echo 7. Run regenerate-notebooks.py to generate release and grader files.
echo 8. Finally, make the notebooks generated under grader-root/relocate/release/
echo     available for students to solve and submit.
echo
echo =============================================================================
echo

set -euxo pipefail

# Change to the script directory
cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")"

# Activate the Python venv
set +x
source server-env/bin/activate
set -x

# Launch jupyter
cd grader-root/relocate
jupyter notebook
