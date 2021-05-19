FROM python:3.8-slim as builder

WORKDIR /usr/src/app

RUN pip install poetry

COPY pyproject.toml poetry.lock ./

RUN poetry export -f requirements.txt > requirements.txt

# 公式からpython3.7 on alpine linuxイメージをpull
FROM python:3.7-slim-stretch

# 作業ディレクトリを設定
WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/requirements.txt .

# 環境変数を設定
# Pythonがpyc filesとdiscへ書き込むことを防ぐ
ENV PYTHONDONTWRITEBYTECODE 1
# Pythonが標準入出力をバッファリングすることを防ぐ
ENV PYTHONUNBUFFERED 1

# psycopg2のインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc python3-dev musl-dev netcat\
    && pip install psycopg2==2.7.7 \
    && apt-get remove -y gcc python3-dev musl-dev

RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# ホストのカレントディレクトリ（現在はappディレクトリ）を作業ディレクトリにコピー
COPY . /usr/src/app/

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
