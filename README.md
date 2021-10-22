# EdX Notebook Grader

Main repository for the External Grade Server used by the Quantum Computer Systems Design course.

Submodule repos:
- [jupyter_grade_server](https://github.com/cduck/jupyter_grade_server)
- [dockernel](https://github.com/cduck/dockernel)
- [lab notebook sources (private)](https://github.com/cduck/quantum_computer_systems_design_labs)


## Install and Run

Install:
```bash
git clone https://github.com/cduck/edx_notebook_grader
cd edx_notebook_grader
git submodule init
git submodule update
./install.sh
```

Create and edit notebooks (one per assignment):
```bash
./edit-notebooks.sh
./regenerate-notebooks.sh
```

Run the server (make sure this is always running, otherwise submissions won't get graded):
```bash
./run-server.sh
```

## EdX Studio Configuration
To use this grader, you must also configure the problem submission page in your EdX course.

How to add the problem submission component:
1. Edit the course with [studio.edx.org](https://studio.edx.org).
2. Go to a subsection and select "Add New Component" > "Problem" > "Advanced" > "Blank Advanced Problem"
3. Click "EDIT" and paste in the below XML:
    ```xml
    <problem>
      <coderesponse queuename="uchicago-qcs-xqueue">
        <label>Submit your completed IPython notebook (.ipynb file) for Lab XX here.  Feedback and any error messages will be shown below.  It may take up to a few minutes to grade.</label>
        <filesubmission id="notebook" allowed_files="psXX.ipynb" required_files="psXX.ipynb"/>
        <codeparam>
          <grader_payload>
            {"name": "psXX"}
          </grader_payload>
        </codeparam>
      </coderesponse>
    </problem>
    ```
4. Remember to replace `psXX` with the actual assignment name (4 locations in the XML) and `uchicago-qcs-xqueue` with the course's XQueue name.
5. Switch from the "EDITOR" to "SETTINGS" and set the "Problem Weight" to 100.
6. "Publish" the subsection and "View Live Version" to test the submission process.  (Clicking "Submit" when viewing the problem in studio.edx.org doesn't work.)

See [the EdX docs on external graders](https://edx.readthedocs.io/projects/edx-partner-course-staff/en/latest/exercises_tools/external_graders.html#olx-definition) for more information.

## File structure for grader-root
- edx_notebook_grader/
    - grader-root/
        - conf.d/
            - [600.json](https://github.com/cduck/jupyter_grade_server#json-configuration-file)
        - relocate/
            - nbgrader_config.py (copy of edx_notebook_grader/nbgrader_config.py)
            - source/ ([see nbgrader docs](https://nbgrader.readthedocs.io/en/latest/index.html))
                - header.ipynb
                - assignment1-name
                    - assignment1-name.ipynb
                - assignemtn2-name
                    - assignment2-name.ipynb
                - ...
            - release/ (generated and used by the server)
            - gradebook.db (generated and used by the server)
    - ...
