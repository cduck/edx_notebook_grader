# EdX Notebook Grader

Main repository for the External Grade Server used by the Quantum Computer Systems Design course.

Submodule repos:
- [jupyter_grade_server](https://github.com/cduck/jupyter_grade_server)
- [dockernel](https://github.com/cduck/dockernel)
- [lab notebook sources (private)](https://github.com/cduck/quantum_computer_systems_design_labs)


# Install and Run

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
./regenerate-notebooks.py
```

Run the server (make sure this is always running, otherwise submissions won't get graded):
```bash
./run-server.sh
```

### File structure for grader-root/
- edx_notebook_grader
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
