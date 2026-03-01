#!/bin/bash

# ===== CONFIG =====
DB_NAME="etl_lab"
DB_USER="etl_user"
HOST="localhost"

echo "Starting Mini Data Warehouse Build..."

echo "1) Creating schema..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/01_create_schema.sql

echo "2) Creating dimensions..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/02_create_dimensions.sql

echo "3) Creating fact table..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/03_create_fact.sql

echo "4) Loading dimensions..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/04_load_dimensions.sql

echo "5) loading fact table..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/05_load_fact.sql

echo "6)Running analytical queries..."
psql -U $DB_USER -d $DB_NAME -h $HOST -f sql/06_analytical_queries.sql

echo "Mini Data Warehouse build complete."
