FROM nvidia/cuda:12.1.1-devel-ubuntu22.04

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt update && apt install -y \
    python3.11 \
    python3-pip \
    git \
    build-essential \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/oobabooga/text-generation-webui.git /app/text-generation-webui

WORKDIR /app/text-generation-webui

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

RUN pip install -r requirements/full/requirements.txt

RUN pip install git+https://github.com/huggingface/transformers.git

RUN mkdir -p models

EXPOSE 7860

CMD ["python3", "server.py", "--listen", "--listen-host", "0.0.0.0"]
