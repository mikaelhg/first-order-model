FROM nvcr.io/nvidia/cuda:10.0-cudnn7-runtime-ubuntu18.04

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
 && DEBIAN_FRONTEND=noninteractive apt-get -qqy install python3-pip ffmpeg git less nano \
 && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app

RUN pip3 install \
  https://download.pytorch.org/whl/cu100/torch-1.0.0-cp36-cp36m-linux_x86_64.whl \
  git+https://github.com/1adrianb/face-alignment \
  -r requirements.txt

# docker run -it --rm --gpus all \
#   -v /home/mikael/Downloads/vox-cpk.pth.tar:/data/check.point:ro \
#   -v /home/mikael/Videos/karpanen.mp4:/data/driving.mp4:ro \
#   -v /home/mikael/Pictures/lumiel_face.png:/data/source.png:ro \
#   -v /tmp/result:/data/result \
#   first-order-model:latest \
#     python3 demo.py --relative --adapt_scale --config config/vox-256.yaml \
#      --checkpoint /data/check.point --driving_video /data/driving.mp4 \
#      --source_image /data/source.png --result_video /data/result/lumiel_karpanen.mp4
