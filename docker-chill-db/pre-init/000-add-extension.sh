#/bin/bash

#stop execution if a command fails
set -e

echo "Creating unaccent extension on database "$POSTGRES_DB	
gosu postgres postgres --single -jE $POSTGRES_DB <<-EOSQL
      CREATE EXTENSION unaccent;
EOSQL
echo

