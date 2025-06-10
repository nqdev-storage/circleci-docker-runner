#!/bin/bash
set -e

# Thư mục chứa config runner
DATA_DIR="/runner/data"

# Biến môi trường cần thiết:
# CIRCLECI_TOKEN: token đăng ký runner
# RUNNER_NAME: tên runner (mặc định my-runner)
# RUNNER_LABELS: labels (mặc định my-label)
# RESOURCE_CLASS: resource class đầy đủ, ví dụ nguyenquy0710/minipc

RUNNER_NAME="${RUNNER_NAME:-my-runner}"
RUNNER_LABELS="${RUNNER_LABELS:-my-label}"
RESOURCE_CLASS="${RESOURCE_CLASS:?RESOURCE_CLASS environment variable is required}"
TOKEN="${CIRCLECI_TOKEN:?CIRCLECI_TOKEN environment variable is required}"

# Nếu chưa có thư mục config, đăng ký runner
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

# Chạy runner
echo "Starting CircleCI runner..."
exec /usr/local/bin/circleci-runner run
