# plain-ipfs
Plain image holding go-ipfs

## Goal

This image should be able to start an isolated IPFS cluster or a cluster hooked to the interstellar filesystem.

### Global
By default the daemon has some seed-nodes configured, to which it will connect and be part of a global IPFS cluster.

### Local
The motivation for this image is to run an IPFS cluster in an isolated DC to use IPFS as a docker volume backend or just as a distributed filesystem for local use, without sharing all blocks with the world.

## Work In Progress

The `docker-compose.yml` provides a deployable stack, even though it's not yet working as intended.

- [] create an isolated IPFS cluster
- [] connect to the world using a NATed service (without exposing the external IP of the docker-host).

### Run it

##### Global mode

When `IPFS_OFFLINE_MODE` is set to `!=true`, the default bootstrap servers are used.
```bash
$ docker stack deploy -c docker-compose.yml ipfs
Creating network ipfs_default
Creating service ipfs_daemon
$ docker logs -f $(docker ps -ql)
[II] qnib/init-plain script v0.4.28
> execute entrypoint '/opt/entry/00-logging.sh'
> execute entrypoint '/opt/entry/10-docker-secrets.env'
[II] No /run/secrets directory, skip step
> execute entrypoint '/opt/entry/99-remove-healthcheck-force.sh'
> execute entrypoint '/opt/qnib/entry/10-ipfs-bootstrap.sh'
initializing IPFS node at /root/.ipfs
generating 2048-bit RSA keypair...done
peer identity: QmQtCq35te4jGGEQkiQaNXAPkaJobJughqnUpaiMFTS3JU
to get started, enter:

	ipfs cat /ipfs/QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv/readme

> execute entrypoint '/opt/qnib/entry/11-ipfs-config.sh'
> execute CMD 'ipfs daemon --routing dht'
Initializing daemon...
Swarm listening on /ip4/10.0.0.2/tcp/4001
Swarm listening on /ip4/10.0.0.3/tcp/4001
Swarm listening on /ip4/10.255.0.3/tcp/4001
Swarm listening on /ip4/10.255.0.4/tcp/4001
Swarm listening on /ip4/127.0.0.1/tcp/4001
Swarm listening on /ip4/172.18.0.3/tcp/4001
Swarm listening on /p2p-circuit/ipfs/QmQtCq35te4jGGEQkiQaNXAPkaJobJughqnUpaiMFTS3JU
Swarm announcing /ip4/10.0.0.2/tcp/4001
Swarm announcing /ip4/10.0.0.3/tcp/4001
Swarm announcing /ip4/10.255.0.3/tcp/4001
Swarm announcing /ip4/10.255.0.4/tcp/4001
Swarm announcing /ip4/127.0.0.1/tcp/4001
Swarm announcing /ip4/172.18.0.3/tcp/4001
API server listening on /ip4/0.0.0.0/tcp/5001
Gateway (readonly) server listening on /ip4/0.0.0.0/tcp/8080
Daemon is ready
```
After some seconds the webui can be reached via [http://localhost:5001/webui/](http://localhost:5001/webui/).

#### Offline mode

In case `IPFS_OFFLINE_MODE==true`, the daemon starts in offline mode.

```bash
$ docker logs -f $(docker ps -ql)
[II] qnib/init-plain script v0.4.28
> execute entrypoint '/opt/entry/00-logging.sh'
> execute entrypoint '/opt/entry/10-docker-secrets.env'
[II] No /run/secrets directory, skip step
> execute entrypoint '/opt/entry/99-remove-healthcheck-force.sh'
> execute entrypoint '/opt/qnib/entry/10-ipfs-bootstrap.sh'
initializing IPFS node at /root/.ipfs
generating 2048-bit RSA keypair...done
peer identity: QmRdxd3WvEDmNFgf9SNuRtaUdgExqjFG4Q5ZUQnJRo4JyJ
to get started, enter:

	ipfs cat /ipfs/QmS4ustL54uo8FzR9455qaxZwuMiUhyvMcX9Ba8nUH4uVv/readme

> execute entrypoint '/opt/qnib/entry/11-ipfs-config.sh'
> execute CMD '/opt/qnib/ipfs/bin/start.sh'
Initializing daemon...
Swarm not listening, running in offline mode.
API server listening on /ip4/0.0.0.0/tcp/5001
Gateway (readonly) server listening on /ip4/0.0.0.0/tcp/8080
Daemon is ready
```
WHen started this way, the webui [http://localhost:5001/webui/](http://localhost:5001/webui/) is not available. :?
