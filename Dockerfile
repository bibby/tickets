FROM python:3.10

ENV PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    POETRY_VERSION=1.2.0 \
    POETRY_HOME=/opt/poetry \
    POETRY_VENV=/opt/poetry-venv \
    POETRY_CACHE_DIR=/opt/.cache

RUN pip install -U pip setuptools \
    && pip install poetry==${POETRY_VERSION}

WORKDIR /opt/src
COPY poetry.lock pyproject.toml ./
RUN poetry check
RUN poetry install --no-interaction --no-cache --without dev

ADD . /opt/src
RUN mkdir static

ENV PYTHONPATH="${PYTHONPATH}:${PWD}"

EXPOSE 8000
ENTRYPOINT /opt/src/entrypoint.sh
