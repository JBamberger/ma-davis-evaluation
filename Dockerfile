FROM python:2.7-buster

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 libboost-python-dev cmake

COPY ./python/requirements.txt ./
RUN python -m pip install -r requirements.txt

COPY ./ ./

RUN perl -pi -e 's/\r\n/\n/g' ./configure.sh
RUN ./configure.sh && make -C build/release

ENV PYTHONPATH=/usr/src/app/python/lib

ENTRYPOINT ["python", "python/tools/eval.py"]