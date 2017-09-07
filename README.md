# plain-ipfs
Plain image holding go-ipfs


## Not yet ready

```bash
$ docker run -ti --rm --network host qnib/plain-ipfs
[II] qnib/init-plain script v0.4.28
> execute entrypoint '/opt/entry/00-logging.sh'
> execute entrypoint '/opt/entry/10-docker-secrets.env'
[II] No /run/secrets directory, skip step
> execute entrypoint '/opt/entry/99-remove-healthcheck-force.sh'
> execute entrypoint '/opt/qnib/entry/10-ipfs-bootstrap.sh'
initializing IPFS node at /root/.ipfs
generating 2048-bit RSA keypair...done
peer identity: QmV3b6UDp5MrBywQKeKpR3WKH1UKJe3F62CEutsERHw6Xv
to get started, enter:

	ipfs cat /ipfs/QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv/readme

> execute entrypoint '/opt/qnib/entry/11-ipfs-config.sh'
> execute CMD 'ipfs daemon --routing dht'
Initializing daemon...
Swarm listening on /ip4/127.0.0.1/tcp/4001
Swarm listening on /ip4/172.17.0.1/tcp/4001
Swarm listening on /ip4/172.18.0.1/tcp/4001
Swarm listening on /ip4/172.19.0.1/tcp/4001
Swarm listening on /ip4/192.168.65.2/tcp/4001
Swarm listening on /ip6/::1/tcp/4001
Swarm listening on /p2p-circuit/ipfs/QmV3b6UDp5MrBywQKeKpR3WKH1UKJe3F62CEutsERHw6Xv
Swarm announcing /ip4/127.0.0.1/tcp/4001
Swarm announcing /ip4/172.17.0.1/tcp/4001
Swarm announcing /ip4/172.18.0.1/tcp/4001
Swarm announcing /ip4/172.19.0.1/tcp/4001
Swarm announcing /ip4/192.168.65.2/tcp/4001
Swarm announcing /ip6/::1/tcp/4001
Error: serveHTTPApi: invalid API address: "/ip4/204/tcp/" (err: failed to parse ip4: 204 failed to parse ip4 addr: 204)
```

Same with NAT-ed network... :(

```bash
$ docker run -ti --rm -p 4001:4001 -p 5001:5001 -p 8080:8080 qnib/plain-ipfs
[II] qnib/init-plain script v0.4.28
> execute entrypoint '/opt/entry/00-logging.sh'
> execute entrypoint '/opt/entry/10-docker-secrets.env'
[II] No /run/secrets directory, skip step
> execute entrypoint '/opt/entry/99-remove-healthcheck-force.sh'
> execute entrypoint '/opt/qnib/entry/10-ipfs-bootstrap.sh'
initializing IPFS node at /root/.ipfs
generating 2048-bit RSA keypair...done
peer identity: QmUnrmy9fEghDBwzfqb5XkXspfbcZs3CmX6YNzbCFk3hir
to get started, enter:

	ipfs cat /ipfs/QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv/readme

> execute entrypoint '/opt/qnib/entry/11-ipfs-config.sh'
> execute CMD 'ipfs daemon --routing dht'
Initializing daemon...
Swarm listening on /ip4/127.0.0.1/tcp/4001
Swarm listening on /ip4/172.17.0.2/tcp/4001
Swarm listening on /p2p-circuit/ipfs/QmUnrmy9fEghDBwzfqb5XkXspfbcZs3CmX6YNzbCFk3hir
Swarm announcing /ip4/127.0.0.1/tcp/4001
Swarm announcing /ip4/172.17.0.2/tcp/4001
Error: serveHTTPApi: invalid API address: "/ip4/172.17.0.2/tcp/" (err: protocol requires address, none given: tcp)
```
