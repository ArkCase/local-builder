ARG VER="1.0"

ARG BASE_REG="ghcr.io"
ARG BASE_REPO="catthehacker/ubuntu"
ARG BASE_VER_PFX=""
ARG BASE_TAG="act-24.04"
ARG BASE_IMG="${BASE_REG}/${BASE_REPO}:${BASE_VER_PFX}${BASE_TAG}"

FROM "${BASE_IMG}"

ARG GH_URL="https://cli.github.com/packages"
ARG GH_GPG="${GH_URL}/githubcli-archive-keyring.gpg"

RUN export KEYRING="/etc/apt/keyrings/githubcli-archive-keyring.gpg" && \
    export DEB_LIST="/etc/apt/sources.list.d/github-cli.list" && \
    export ARCH="$(dpkg --print-architecture)" && \
    curl -fsSL "${GH_GPG}" -o "${KEYRING}" && \
    chmod a=r "${KEYRING}" && \
    echo "deb [arch=${ARCH} signed-by=${KEYRING}] ${GH_URL} stable main" > "${DEB_LIST}" && \
    apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install \
        gettext-base \
        gh \
      && \
    apt clean && \
    find /var/lib/apt/lists -type f -delete
