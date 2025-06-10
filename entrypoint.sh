#!/bin/bash
set -e

DATA_DIR="/runner/data"

RUNNER_NAME="${RUNNER_NAME:-my-runner}"
RUNNER_LABELS="${RUNNER_LABELS:-my-label}"
RESOURCE_CLASS="${RESOURCE_CLASS:?RESOURCE_CLASS environment variable is required}"
TOKEN="${CIRCLECI_TOKEN:?CIRCLECI_TOKEN environment variable is required}"

if [ ! -d "$DATA_DIR" ] || [ ! -f "$DATA_DIR/runner.yaml" ]; then
  echo "Registering CircleCI runner..."
  /usr/local/bin/circleci-runner register \
    --token "$TOKEN" \
    --name "$RUNNER_NAME" \
    --labels "$RUNNER_LABELS" \
    --working-directory "$DATA_DIR" \
    --resource-class "$RESOURCE_CLASS"
else
  echo "Runner already registered."
fi

echo "Starting CircleCI runner..."
exec /usr/local/bin/circleci-runner run
