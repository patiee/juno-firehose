FROM golang:latest

# Build Juno Binary
ARG arch=x86_64

WORKDIR /juno
COPY juno .

RUN go build -o bin/junod ./cmd/junod

# rest server
EXPOSE 1317
# tendermint p2p
EXPOSE 26656
# tendermint rpc
EXPOSE 26657

# Build Firehose cosmos
WORKDIR /app
COPY firehose-cosmos .

RUN go mod download
RUN make build

# Configuration
RUN addgroup --gid 1234 firehose-cosmos
RUN adduser --system --uid 1234 firehose-cosmos
RUN chown -R firehose-cosmos:firehose-cosmos /app

USER 1234

RUN mkdir -p output 

RUN ["/app/build/firehose-cosmos", "init"]
COPY firehose.yaml .
COPY app.toml /home/firehose-cosmos/.juno/config/app.toml
COPY config.toml /home/firehose-cosmos/.juno/config/config.toml
COPY genesis.json /home/firehose-cosmos/.juno/config/genesis.json

USER root
RUN chmod 777 -R /home/firehose-cosmos


USER 1234
CMD ["/app/build/firehose-cosmos", "start", "--config=./firehose.yaml"]