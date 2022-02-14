#!/usr/bin/env bash
docker image build . -t michaelvanvliet/lacdr-teachopencadd-materials:latest
docker run -it --cpus=4 -p 8888:8888 -v ${PWD}:/home/jovyan/work -e JUPYTER_ENABLE_LAB=yes -e GRANT_SUDO=yes --user root michaelvanvliet/lacdr-teachopencadd-materials:latest start-notebook.sh # --NotebookApp.token=''
# docker push michaelvanvliet/lacdr-teachopencadd-materials:latest