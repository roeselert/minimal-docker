FROM python:3.6-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

RUN apt-get update \
 && apt-get install -y --no-install-recommends git wget \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/roeselert/minimal-docker/master/requirements.txt

RUN pip install --no-cache -r requirements.txt

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN git clone https://github.com/ageron/handson-ml

RUN git clone https://github.com/roeselert/achim

