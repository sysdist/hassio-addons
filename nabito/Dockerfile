######################
# Stage: builder
FROM ruby:2.6.1-alpine as Builder


#FROM ruby:alpine3.9 as builder
#ARG FOLDERS_TO_REMOVE
#ARG BUNDLE_WITHOUT
#ARG RAILS_ENV
# ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}
# ENV RAILS_ENV ${RAILS_ENV}

ENV BUNDLE_WITHOUT=development:test
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=foo
ENV RAILS_SERVE_STATIC_FILES=true

RUN apk add --update --no-cache \
    build-base sqlite-dev \
    postgresql-dev postgresql-client \
    git jq yarn \
    imagemagick \
    nodejs-current \
    tzdata file \
    && mkdir /app

WORKDIR /app

# Install gems and Remove unneeded files (cached *.gem, *.o, *.c)
ADD rootfs/app/Gemfile* /app/

RUN gem install -N bundler \
 && bundle config --global frozen 1 \
 && bundle install -j4 --retry 3 \
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

# Add the Rails app
COPY rootfs /

# Precompile assets
RUN bundle exec rake assets:precompile

# Remove folders not needed in resulting image
#RUN rm -rf $FOLDERS_TO_REMOVE
RUN rm -rf spec node_modules app/assets vendor/assets lib/assets tmp/cache


###############################
# Stage Final
FROM ruby:2.6.1-alpine as final
#LABEL maintainer="mail@georg-ledermann.de"

#ARG ADDITIONAL_PACKAGES
#ARG EXECJS_RUNTIME

# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client sqlite-libs \
    tzdata jq \
    file

# Add Alpine packages
# RUN apk add --update --no-cache \
#     postgresql-client sqlite-dev \
#     imagemagick \
#     nodejs-current build-base git jq \
#     tzdata \
#     file

COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app /app

COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh

# # Add user
# RUN addgroup -g 1000 -S app \
#  && adduser -u 1000 -S app -G app
# USER app

# # Copy app with gems from former build stage
# COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
# COPY --from=builder --chown=app:app /app /app

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true
ENV EXECJS_RUNTIME "Disabled"

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
#RUN date -u > BUILD_TIME

# Start up
#CMD ["docker/startup.sh"]

ENTRYPOINT ["run.sh"]



# FROM ruby:alpine3.9

# LABEL maintainer="Systems Distributed SK <sysdist.com@gmail.com>"

# ENV BUILD_PACKAGES="curl-dev ruby-dev build-base jq" \
#     DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
#     RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml nodejs" \
#     RAILS_VERSION="5.2.2"

# RUN \
#   apk --update --upgrade add $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
#   gem install -N bundler

# # cleanup and settings  
# RUN gem install -N nokogiri -- --use-system-libraries && \
#   gem install -N rails --version "$RAILS_VERSION" && \
#   echo 'gem: --no-document' >> ~/.gemrc && \
#   cp ~/.gemrc /etc/gemrc && \
#   chmod uog+r /etc/gemrc && \
#   bundle config --global build.nokogiri  "--use-system-libraries" && \
#   bundle config --global build.nokogumbo "--use-system-libraries" && \
#   find / -type f -iname \*.apk-new -delete && \
#   rm -rf /var/cache/apk/* && \
#   rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
#   rm -rf ~/.gem

# COPY rootfs /
# WORKDIR /nabito
# RUN bundle install --without development test

# #RUN bundle exec rake db:create


# # Add a script to be executed every time the container starts.
# COPY run.sh /usr/bin/
# RUN chmod +x /usr/bin/run.sh
# ENTRYPOINT ["run.sh"]

# # Start the main process.
# #CMD ["/bin/sh"]

