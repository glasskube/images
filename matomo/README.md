# matomo-docker

**Build and push:**

```shell
MATOMO_TAG="ghcr.io/glasskube/matomo-docker:4.13.0-apache"
docker build -t $MATOMO_TAG .
docker push $MATOMO_TAG
```

**Container tasks:**

```shell
rsync -crlOt --no-owner --no-group --no-perms /usr/src/matomo/ /var/www/html/
./console plugin:activate ExtraTools && ./console matomo:install --install-file=/tmp/matomo/install.json --force --do-not-drop-db

```