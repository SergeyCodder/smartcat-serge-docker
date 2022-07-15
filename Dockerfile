FROM alpine:3.13

ARG GIT_SHA1
ARG SERGE_BUILD

ARG INSTALL_PREREQUISITES="dumb-init openssh git perl perl-app-cpanminus make perl-xml-parser perl-text-diff perl-yaml-libyaml perl-mime-lite perl-file-copy-recursive perl-authen-sasl perl-io-string perl-path-tiny perl-xml-libxml perl-xml-libxslt perl-xml-tidy perl-xml-twig perl-text-csv_xs perl-json perl-json-xs perl-net-smtp-ssl perl-dbd-sqlite"

ARG SMARTCAT_APP_INSTALL_PREREQUISITES="make perl-moose perl-module-build perl-module-build-tiny perl-log-any perl-log-log4perl perl-test-exception perl-test-mockmodule perl-datetime perl-clone perl-yaml perl-class-accessor perl-file-remove perl-file-which perl-config-tiny perl-string-rewriteprefix perl-extutils-config perl-spiffy perl-json perl-test-pod perl-net-http perl-text-diff perl-clone perl-importer perl-datetime perl-params-util perl-sub-install perl-string-rewriteprefix perl-class-load perl-libwww perl-lwp-protocol-https perl-log-log4perl perl-file-which perl-super"

ARG RCLONE_INSTALL_PREREQUISITES="ca-certificates fuse"

ARG CLEAN_PREREQUISITES="make perl-app-cpanminus perl-module-build perl-module-build-tiny perl-test-exception perl-test-mockmodule perl-test-pod"

ARG SMARTCAT_APP_CLEAN_PREREQUISITES="perl-module-build perl-module-build-tiny perl-test-exception perl-test-mockmodule"

ARG RCLONE_VERSION="v1.56.0"

LABEL maintainers="Igor Afanasyev <igor@smartcat.ai>"
LABEL serge_git_sha1="${GIT_SHA1}"

COPY /serge /serge
COPY /replacement/smartcat_v2.pm /serge/lib/Serge/Sync/Plugin/TranslationService/

RUN set -ex \
    && echo apk add --no-cache ${INSTALL_PREREQUISITES} ${SMARTCAT_APP_INSTALL_PREREQUISITES} ${RCLONE_INSTALL_PREREQUISITES} > /tmp/commands \
    && . /tmp/commands \
    && rm /tmp/commands \
    && cpanm --no-wget --installdeps /serge \
    && cpanm --no-wget Smartcat::App \
    && rm -rf /root/.cpan* /usr/local/share/man /serge/t /serge/_build \
    && echo apk del -f --purge ${CLEAN_PREREQUISITES} ${SMARTCAT_APP_CLEAN_PREREQUISITES} > /tmp/commands \
    && . /tmp/commands \
    && rm /tmp/commands \
    && cd /tmp \
    && wget -q https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip \
    && unzip /tmp/rclone-${RCLONE_VERSION}-linux-amd64.zip \
    && mv /tmp/rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/bin \
    && rm -r /tmp/rclone* \
    && addgroup rclone \
    && adduser -h /config -s /bin/ash -G rclone -D rclone

ENV PAGER="less -FR~"
ENV PATH="/root/bin:/serge/bin:${PATH}"
ENV PERL5LIB="/serge/lib${PERL5LIB:+:}${PERL5LIB}"
ENV SERGE_DATA_DIR=/root
ENV SERGE_BUILD="${SERGE_BUILD}"

#VOLUME /data
WORKDIR /root

COPY /bin /usr/local/bin

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
