FROM rocker/r-ver:3.6.3

ENV RVERS 3.6.3

## Download and install dependencies
RUN apt-get update \
  && apt-get install -y --no-install-recommends file git libssh2-1-dev libxml2-dev zlib1g-dev libapparmor1 libclang-dev libcurl4-gnutls-dev libgit2-dev libedit2 libssl-dev lsb-release multiarch-support psmisc procps python-setuptools sudo wget \
  ## configure git not to request password each time
  && git config --system credential.helper 'cache --timeout=3600' \
  && git config --system push.default simple \
  # install r-packages
  && cd ~ \
  && wget --quiet https://git.nilu.no/jmll/r-vers/-/archive/${RVERS}/r-vers-${RVERS}.tar.gz \
  && tar xzf r-vers-${RVERS}.tar.gz \
  && cd r-vers-${RVERS} \
  && Rscript ./lib/buildpkgs.R \
  && cd .. \
  && rm -r r-vers-${RVERS} \
  && rm r-vers-${RVERS}.tar.gz

CMD ["R"]
