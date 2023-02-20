# matomo

**Build and push:**

```shell
MATOMO_TAG="glasskube/matomo:4.13.3"
docker build -t $MATOMO_TAG .
```

**Container tasks:**

```shell
rsync -crlOt --no-owner --no-group --no-perms /usr/src/matomo/ /var/www/html/
./console plugin:activate ExtraTools && ./console matomo:install --install-file=/tmp/matomo/install.json --force --do-not-drop-db

```