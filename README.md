## juno-contracts

### Juno
clone
```
    git clone git@github.com:figment-networks/juno.git
    cd juno && git checkout firehose-v3.0.0
```

If you want to instrument any other version replace cosmos-sdk and tendermint inside `go.mod` in juno
```
    github.com/tendermint/tendermint => github.com/figment-networks/tendermint firehose-v0.34.16
    github.com/cosmos/cosmos-sdk => github.com/figment-networks/cosmos-sdk firehose-v0.45.1
```
fix go.mod
```
    go mod tidy
```

### Firehose Cosmos
clone
```
   git clone git@github.com:figment-networks/firehose-cosmos.git
   cd firehose-cosmos && git checkout feature/substreams
```

### Graph node

### Download genesis file
```
    curl https://share.blockpane.com/juno/phoenix/genesis.json > ./genesis.json
```

### Build Dockerfiles
```
    docker build -t juno-v3.0.0 --platform linux/x86_64 .
    docker run -it --platform linux/x86_64 --restart always --expose 9030 -p 9030:9030 juno-v3.0.0 
```

Run graph node
```
cargo run -p graph-node --release -- \                                      
  --postgres-url postgresql://patrycja:@localhost:5432/graph-node \
  --ethereum-rpc juno-1:http://0.0.0.0:9000 \
  --ipfs 127.0.0.1:5001
```

Note that during first start-up blocks will be indexed after 30 minutes 


Juno Upgrades guide:
https://docs.junonetwork.io/validators/mainnet-upgrades

