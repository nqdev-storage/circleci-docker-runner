#!/bin/bash
set -e

if [ -z "$RUNNER_TOKEN" ]; then
  echo "ERROR: RUNNER_TOKEN is not set."
  exit 1
fi

# Cấu hình runner
circleci-runner install \
  --url https://circleci.com \
  --token "$RUNNER_TOKEN"

# Khởi chạy runner
circleci-runner start
