#!/usr/bin/env python
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

from path import Path
from nbgrader.api import Gradebook, InvalidEntry
from nbgrader.apps.generateassignmentapp import GenerateAssignmentApp


base_path = Path(__file__).parent / 'grader-root' / 'relocate'


# Remove old data
try:
    (base_path / 'gradebook.db').remove()
except FileNotFoundError:
    pass
(base_path / 'autograded').rmtree(ignore_errors=True)
(base_path / 'feedback').rmtree(ignore_errors=True)
(base_path / 'release').rmtree(ignore_errors=True)


# Generate assignments (released versions are put in the 'release' directory)
def generate_assignment(lab_name):
    gen = GenerateAssignmentApp()
    gen.init_syspath = lambda: None
    gen.initialize([lab_name])
    gen.start()

for assn_path in (base_path / 'source').listdir():
    if not assn_path.isdir():
        continue
    generate_assignment(assn_path.basename)


# Add student to database
with Gradebook('sqlite:///relocate/gradebook.db') as gb:
    # Populate database with one student, "student", used by the auto grader
    gb.add_student('student')
    #for i in range(10):
    #    gb.add_assignment(f'ps{i:02}')
