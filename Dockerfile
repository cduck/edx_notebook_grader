FROM python:3.8-slim-buster

RUN pip install --upgrade pip ipython ipykernel
RUN pip install --upgrade numpy matplotlib networkx qiskit~=0.24.0 cirq~=0.10.0

# Configure grader user
RUN useradd -m grader
rm -rf /home/grader
##RUN chown -R grader:grader /home/grader
USER grader
# Add user site-packages to python path
##RUN pip install --user --upgrade pip

CMD cp $DOCKERNEL_CONNECTION_FILE /tmp/spec.json
CMD python -m ipykernel_launcher -f /tmp/spec.json
