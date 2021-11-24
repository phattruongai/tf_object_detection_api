FROM tensorflow/tensorflow:2.7.0-gpu

ARG DEBIAN_FRONTEND=noninteractive

# Install apt dependencies
RUN apt-get update && apt-get install -y \
    git \
    protobuf-compiler \
    wget

# Add new user to avoid running as root
RUN useradd -ms /bin/bash tensorflow
USER tensorflow
WORKDIR /home/tensorflow

# Copy this version of of the model garden into the image
RUN git clone --depth 1 https://github.com/tensorflow/models
# COPY --chown=tensorflow . /home/tensorflow/models

# Compile protobuf configs
RUN cd models/research/ && \
    protoc object_detection/protos/*.proto --python_out=. && \
    cp object_detection/packages/tf2/setup.py . && \
    sed -i 's/>=2.5.1/==2.5.0/' setup.py && \
    python -m pip install .

ENV PATH="/home/tensorflow/.local/bin:${PATH}"

RUN pip install --upgrade pip && pip install jupyter

RUN pip install pyparsing==2.4.2

RUN mkdir /home/tensorflow/serve

WORKDIR /home/tensorflow/serve

# CMD ["jupyter","notebook","--no-browser","--port","8888","--ip","0.0.0.0"]