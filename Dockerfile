FROM golang:latest

# Build Juno Binary
ARG arch=x86_64

WORKDIR /juno
COPY juno .

RUN go build -o bin/junod ./cmd/junod 

# firehose 
EXPOSE 9030

# Build Firehose cosmos
WORKDIR /app
COPY firehose-cosmos .

RUN mkdir -p /output
RUN chmod 777 /output

RUN go mod download
RUN make build

# Configuration
RUN addgroup --gid 1234 firehose-cosmos
RUN adduser --system --uid 1234 firehose-cosmos
RUN chown -R firehose-cosmos:firehose-cosmos /app

USER 1234

RUN ["/app/build/firehose-cosmos", "init"]

COPY firehose.yaml .
COPY firehose-merger.yaml .
COPY app.toml /home/firehose-cosmos/.juno/config/app.toml
COPY config.toml /home/firehose-cosmos/.juno/config/config.toml
COPY genesis.json /home/firehose-cosmos/.juno/config/genesis.json

USER root
RUN chmod 777 -R /home/firehose-cosmos


USER 1234
CMD ["/app/build/firehose-cosmos", "start", "--config=./firehose.yaml"]
