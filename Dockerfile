FROM cgr.dev/chainguard/python:latest-dev as dev

WORKDIR /app

RUN python -m venv venv
ENV PATH="/app/venv/bin":$PATH
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install flask


FROM cgr.dev/chainguard/python:latest as prod

WORKDIR /app
COPY app.py .
COPY --from=dev /app/venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
COPY templates templates/
COPY static static/

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]