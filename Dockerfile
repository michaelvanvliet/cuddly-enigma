FROM jupyter/datascience-notebook:python-3.7.6

RUN echo "BUILD Teach OpenCADD for TLJH"
RUN wget https://github.com/volkamerlab/teachopencadd/archive/master.zip -O teachopencadd.zip
RUN mkdir -p /home/jovyan
RUN unzip teachopencadd.zip -d /home/jovyan
RUN cd /home/jovyan/teachopencadd-master/teachopencadd/talktorials

RUN conda install mamba -n base -c conda-forge
#RUN conda update -n base conda

COPY teachopencadd_env.yml teachopencadd_env.yml
RUN mamba env create -f teachopencadd_env.yml

RUN echo "conda activate teachopencadd" >> ~/.bashrc
ENV PATH /opt/conda/envs/teachopencadd/bin:$PATH

ENV CONDA_DEFAULT_ENV teachopencadd
# RUN conda init bash
RUN conda --version && source /opt/conda/etc/profile.d/conda.sh && \
    conda init bash && \
    conda activate teachopencadd && \
    conda install jupyterlab=3 nglview -c conda-forge -y  && \
    jupyter-nbextension enable nglview --py --sys-prefix  && \
    jupyter labextension install  nglview-js-widgets
RUN python -m ipykernel install --user --name teachopencadd --display-name "LACDR - teachopencadd Kernel"