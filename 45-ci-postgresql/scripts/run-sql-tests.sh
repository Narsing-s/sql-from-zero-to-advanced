#!/usr/bin/env bash
set -euo pipefail

: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGUSER:=postgres}"
: "${PGDATABASE:=sql_curriculum}"

export PGHOST PGPORT PGUSER PGDATABASE

psql -v ON_ERROR_STOP=1 -f fixtures/001-base.sql
psql -v ON_ERROR_STOP=1 -f tests/001-core.sql

echo "PostgreSQL curriculum tests passed."