FROM python:3.9

WORKDIR /usr/projeto

ENV SECRET_KEY=justasomekeytocandevelop \
    DEBUG=True \
    # superuser
    DJANGO_SUPERUSER_EMAIL=nupexample@example.com \
    DJANGO_SUPERUSER_PASSWORD=nuperoot \
    # db
    DATABASE_URL=postgres://usuario:senha@db:5432/banco

# build-essential para utilizar o "make" do sphinx
RUN apt-get update && apt-get install git build-essential -y && \
    pip3 install poetry==1.0.5 && \
    poetry config virtualenvs.create false

COPY poetry.lock pyproject.toml /usr/projeto/
RUN poetry install --no-root

# instala os git hooks
# COPY .pre-commit-config.yaml /usr/projeto
# COPY .git /usr/projeto/.git
# RUN pre-commit install -t pre-commit -t pre-push

COPY backend /usr/projeto/backend
RUN poetry install