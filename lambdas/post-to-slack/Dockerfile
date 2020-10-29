FROM python:3.7 as builder

COPY poetry.lock pyproject.toml ./

# ENV PATH=/root/.local:$PATH

RUN pip install poetry==1.1.4 awscli==1.18.167 \
    && poetry export -f requirements.txt --output requirements.txt \
    && pip install -r requirements.txt -t /root/vendor

FROM python:3.7-slim
WORKDIR /app

COPY --from=builder /root/vendor /app/vendor
COPY main.py /app

RUN apt-get update \
    && apt-get -yqq install zip --no-install-recommends \
    && zip -r9 /tmp/deployment.zip /app/vendor \
    && zip -g /tmp/deployment.zip main.py \
    && ls -lt \
    && pwd \
    && ls -lt /tmp 