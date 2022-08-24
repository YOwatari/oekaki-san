FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

RUN --mount=type=cache,target=/var/lib/apt/lists \
    --mount=type=cache,target=/var/cache/apt/archives \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        curl ca-certificates \
        git git-lfs \
        libglib2.0-0 libsm6 libxrender1 libxext-dev

RUN set -x \
    && curl -sSL -o miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash miniconda3.sh -b -p /opt/miniconda3 \
    && rm -rf miniconda3.sh \
    && /opt/miniconda3/bin/conda init bash
ENV PATH /opt/miniconda3/bin:$PATH

RUN set -x \
    && git clone https://github.com/CompVis/stable-diffusion \
    && cd stable-diffusion \
    && conda env create -f environment.yaml \
    && echo "conda activate ldm" >> ~/.bashrc
ENV CONDA_DEFAULT_ENV ldm
ENV PATH /opt/miniconda3/envs/ldm/bin:$PATH
