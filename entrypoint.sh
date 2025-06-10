#!/bin/bash
set -e

echo "🟢 Starting CircleCI Launch Agent..."
exec /usr/local/bin/circleci-launch-agent
