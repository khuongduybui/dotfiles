#! /bin/bash

aws --profile "hawk" secretsmanager get-secret-value --secret-id "dev/jenkins/artifacts-gov" --region "us-east-1" --output json | jq -r .SecretString | jq ".Version=1 | .AccessKeyId=.access_key | del(.access_key) | .SecretAccessKey=.secret_key | del(.secret_key)"
