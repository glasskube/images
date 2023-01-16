#!/bin/bash

RESULT_OK=0
RESULT_NOK=1
RESULT_FAIL=2

DB_NAME="odoo"

function abort {
  reason=$1
  echo "Fatal: $reason"
  exit 1
}

function check_db {
  echo "Wait until DB is running…"
  if ! wait-for-psql.py --db_host "$HOST" --db_port 5432 --db_user "$USER" --db_password "$PASSWORD" --timeout 60; then
    return $RESULT_FAIL
  fi

  echo "Check if table 'res_users' exists…"
  PGHOST="$HOST" PGUSER="$USER" PGPASSWORD="$PASSWORD" PGDATABASE="$DB_NAME" \
    psql -qc "select * from res_users" \
    >/dev/null

  RESULT_CODE=$?
  echo "PSQL exit code: $RESULT_CODE"

  return $RESULT_CODE
}

function init_db {
  /entrypoint.sh "$@" "--init" "base" "-d" "$DB_NAME" "--stop-after-init"
}

function update_db {
  /entrypoint.sh "$@" "--update" "base" "-d" "$DB_NAME" "--stop-after-init"
}

check_db

case $? in
"$RESULT_OK")
  echo "Database already initialized"
  update_db "$@"
  ;;
"$RESULT_NOK")
  echo "Initializing database"
  init_db "$@"
  ;;
*)
  abort "Error connecting to database server"
  ;;
esac

exec "/entrypoint.sh" "$@"
