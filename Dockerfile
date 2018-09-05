ARG DOCKER_REGISTRY=docker.io
ARG DOCKER_IMG_TAG=":latest"
ARG DOCKER_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/qnib/uplain-init${DOCKER_IMG_TAG}${DOCKER_IMG_HASH}

ENV ENTRYPOINTS_DIR=/opt/qnib/entry/

RUN apt-get update \
 && apt-get install -y wget
RUN mkdir -p /usr/local/bin/
RUN wget -qO /usr/local/bin/go-github https://github.com/qnib/go-github/releases/download/0.3.0/go-github_0.3.0_Linux
RUN chmod +x /usr/local/bin/go-github
RUN echo "# ipfs: $(/usr/local/bin/go-github rLatestUrl --ghorg ipfs --ghrepo go-ipfs --regex linux-amd64.tar.gz --limit 1)"
RUN wget -qO- "$(/usr/local/bin/go-github rLatestUrl --ghorg ipfs --ghrepo go-ipfs --regex linux-amd64.tar.gz --limit 1)" |tar xfz - -C /usr/local/ \
 && mv /usr/local/go-ipfs/ipfs /usr/local/bin/
RUN apt-get install -yqq iproute2
VOLUME ["/data/ipfs"]
COPY opt/qnib/entry/*.sh /opt/qnib/entry/
COPY opt/qnib/ipfs/bin/start.sh /opt/qnib/ipfs/bin/
CMD ["/opt/qnib/ipfs/bin/start.sh"]
