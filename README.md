## juno-contracts

### Prepare Juno
clone
```
    git clone git@github.com:CosmosContracts/juno.git
    cd juno && git checkout v3.0.0
```
replace cosmos-sdk and tendermint inside `go.mod` in juno
```
    github.com/tendermint/tendermint => github.com/figment-networks/tendermint firehose-v0.34.16
    github.com/cosmos/cosmos-sdk => github.com/figment-networks/cosmos-sdk firehose-v0.45.1
```
fix go.mod
```
    go mod tidy
```

### Prepare Firehose Cosmos
clone
```
   git clone git@github.com:figment-networks/firehose-cosmos.git
   cd firehose-cosmos && git checkout feature/substreams
```

### Download genesis file
```
    curl https://share.blockpane.com/juno/phoenix/genesis.json > ./genesis.json
```

### Build Dockerfile for instrumented firehose juno node
```
    docker build -t juno-v3.0.0 --platform linux/x86_64 .
    docker run -it --platform linux/x86_64 --restart always juno-v3.0.0
```

Note that during first start-up blocks will be indexed after 30 minutes 
