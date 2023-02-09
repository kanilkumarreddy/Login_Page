FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
CMD ["python", "manage.py", "runserver"]




FROM artifactory.global.standardchartered.com/mlops/swoosh-images/swoosh-ocr-image:14

WORKDIR /

COPY . .

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8 

#RUN yum  install build-essential cmake unzip pkg-config -y
#RUN yum install enchant -y
#RUN yum install libXext libSM libXrender -y

RUN pip install -r requirements.txt

RUN chmod -R 775 app ml manage.py requirements.txt leptonical tesseractl

ENV PATH=/tesseractl/bin:$PATH \
    TESSDATA_PREFIX=/tessaractdata/tessdata 

RUN cp -rf ml/src/punkt /opt/app-root/src/nltk_data/

RUN useradd -g root pyuser

ENV no_proxy=.global.standardchartered.com,.internal.sc.com,.eks.amazonaws.com,.standardchartered.com,identity-hk-sit.api.dev.net,gateway-hk-sit.api.dev.net,identity-hk.api.sc.net,gateway-hk.api.sc.net,sdkms.intranet.sc.net
ENV http_proxy=
ENV https_proxy=

USER pyuser
CMD gunicorn app.wsgi:application -b 0.0.0.0:8884 -t 1000
EXPOSE 8884
