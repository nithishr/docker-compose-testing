FROM couchbase
LABEL author="Nithish Raghunandanan"
USER root
RUN apt update -y && apt -y upgrade 
RUN apt -y install python python3-pip sudo
RUN pip3 install --upgrade pip
# Switch back to jovyan to avoid accidental container runs as root
RUN useradd -m jovyan
EXPOSE 8888
EXPOSE 8091-8097
EXPOSE 9140
EXPOSE 11210
EXPOSE 11211

USER jovyan
RUN pip install jupyter
COPY notebooks /home/jovyan/work/notebooks
USER root

COPY entrypoint.sh cmd.sh
ENTRYPOINT ["bash", "cmd.sh"]
