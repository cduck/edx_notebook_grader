FROM python:3.8-slim-buster

RUN pip install --upgrade pip ipython ipykernel
RUN pip install --upgrade numpy matplotlib networkx qiskit~=0.24.0 cirq~=0.13.1 pyzx==0.6.4 ipywidgets==7.5.1

# Configure grader user
RUN useradd -m grader
RUN rm -rf /home/grader
##RUN chown -R grader:grader /home/grader
USER grader
# Add user site-packages to python path
##RUN pip install --user --upgrade pip

CMD cp $DOCKERNEL_CONNECTION_FILE /tmp/spec.json
CMD python -m ipykernel_launcher -f /tmp/spec.json
