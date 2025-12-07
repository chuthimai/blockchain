# Private Geth POA Network Setup Guide

## Step 1: Create node folder

```bash
mkdir node1
```

## Step 2: Create account for node

```bash
cd node1
geth --datadir "./data" account new
```

This generates the **keystore** folder inside `data`.

## Step 3: Setup block network using puppeth

```bash
cd ../
puppeth
```

- Network name: `blockpoa`\
- Choose **configure new genesis**\
- Choose **create new genesis**\
- Choose **Clique (Proof-of-Authority)**\
- Block time (seconds): `5`\
- Accounts allowed to seal: signer node\
- Accounts pre-funded: MetaMask account\
- Pre-fund with 1 wei: OK\
- Network ID: `13579`\
- Choose **manage existing genesis**\
- Export genesis configuration (default)\
- Exit

## Step 4: Config node

```bash
cd node1
geth --datadir ./data init ../blockpoa.json
```

This generates the **geth** folder inside `data`.

## Step 5: Create boot node

```bash
cd bnode
bootnode -genkey boot.key
```

## Step 6: Save node password

```bash
touch node1/password.txt && echo "node1" > node1/password.txt
```

## Step 7: Connect all nodes

### Start bootnode

```bash
cd bnode
bootnode -nodekey "./boot.key" -verbosity 7 -addr "127.0.0.1:30301"
```

### Start node1

```bash
cd node1
geth --networkid 13579 --datadir "./data" --bootnodes enode://50a0b00bca50df4bc49e62e012993df3f388fb74df6749359466c81c14922e1d7b25eb67d3d8a624b651884d39e2dfb343f008a09f32613e76cb919c891a8000@127.0.0.1:0?discport=30301 --port 30303 --ipcdisable --syncmode full --http --allow-insecure-unlock --http.corsdomain "*" --http.port 8545 --unlock 0xD94E9BCDfa317a4cDBff53F28621Bd680c57B71f --password password.txt --mine --miner.etherbase=0xD94E9BCDfa317a4cDBff53F28621Bd680c57B71f console
```

### Start node2

```bash
cd node2
geth --networkid 13579 --datadir "./data" --bootnodes enode://50a0b00bca50df4bc49e62e012993df3f388fb74df6749359466c81c14922e1d7b25eb67d3d8a624b651884d39e2dfb343f008a09f32613e76cb919c891a8000@127.0.0.1:0?discport=30301 --port 30305 --ipcdisable --syncmode full --http --allow-insecure-unlock --http.corsdomain "*" --http.port 8546 --authrpc.port 8552 --unlock 0x184c6bbd7d103AD4737b08553f645e506D268d35 --password password.txt --mine --miner.etherbase=0x184c6bbd7d103AD4737b08553f645e506D268d35 console
```
