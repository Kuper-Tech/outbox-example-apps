ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG POSTGRES_VERSION
ARG RUBYGEMS_VERSION
ARG BUNDLER_VERSION

ENV RAILS_ENV=development

# Common dependencies
RUN apt-get update -qq \
  && apt-get dist-upgrade -y \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    pkg-config \
    ca-certificates \
    curl \
    wget \
    less \
    git \
    vim \
    shared-mime-info \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log


# Postgres client
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgres-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/postgres-archive-keyring.gpg] https://apt.postgresql.org/pub/repos/apt/" bookworm-pgdg main $POSTGRES_VERSION | tee /etc/apt/sources.list.d/postgres.list > /dev/null

# App's dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    postgresql-client-${POSTGRES_VERSION} \
    libpq-dev \
    file \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
RUN gem update --system ${RUBYGEMS_VERSION} \
  && gem install --default bundler -v ${BUNDLER_VERSION}

EXPOSE 3000

CMD ["/usr/bin/bash"]
