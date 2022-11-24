FROM matomo:4.12.3-apache
LABEL org.opencontainers.image.source=https://github.com/glasskube/matomo-docker

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends rsync;

COPY config.ini.php /usr/src/matomo/config/config.ini.php
COPY ExtraTools /usr/src/matomo/plugins/ExtraTools/
