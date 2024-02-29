ARG BUILD_BASE_IMAGE_REGISTRY
ARG BUILD_BASE_IMAGE_NAME
ARG BUILD_BASE_IMAGE_TAG
ARG BUILD_DEPENDENCIES

# =============== Base image ===============
FROM ${BUILD_BASE_IMAGE_REGISTRY}/${BUILD_BASE_IMAGE_NAME}:${BUILD_BASE_IMAGE_TAG} as base-image

ARG APP_PATH=/app
ARG RUBYGEMS_VERSION=3.5.6
ARG BUNDLER_VERSION=2.5.5

ENV LANG=C.UTF-8
ENV BUNDLE_PATH=${APP_PATH}/bundle
ENV GEM_HOME=${APP_PATH}/bundle

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN gem update --system ${RUBYGEMS_VERSION} \
  && gem install --default bundler -v ${BUNDLER_VERSION}

RUN chown -R application:application /app && \
  bundle config --local deployment 'true' && \
  bundle config --local path "${BUNDLE_PATH}" && \
  bundle config --local clean 'true' && \
  bundle config --local no-cache 'true'

# =============== Production image ===============
FROM base-image as bundle-prod

ENV RAILS_ENV=production

RUN bundle install \
  --without development test \
  --jobs=8 \
  --retry=3

# =============== Test image ===============
FROM base-image as bundle-development

ENV RAILS_ENV=test

RUN bundle install \
  --jobs=8 \
  --retry=3

# =============== Final image ===============
FROM bundle-${BUILD_DEPENDENCIES} AS final

COPY . $APP_PATH
COPY --chown=application . $APP_PATH

USER 10001

ENV PATH="${APP_PATH}/bin:${PATH}"

ARG GIT_TAG=0.0.0-dev
ARG BUILD=HEAD

ENV GIT_TAG=$GIT_TAG
ENV BUILD=$BUILD
