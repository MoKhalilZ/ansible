#!/bin/sh
echo "backup all databases"
mysqldump -u root --single-transaction --quick --lock-tables=false --all-databases | gzip > /backup/full-$(date +%F).sql.gz
echo "Copy backup to s3"
aws s3 cp /backup/full-$(date +%F).sql.gz s3://replace_with_s3_bucket
echo "delete backup from server"
rm -f /backup/full-$(date +%F).sql.gz
