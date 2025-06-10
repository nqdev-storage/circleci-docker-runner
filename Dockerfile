FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LAUNCH_AGENT_VERSION=1.0.16427

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    unzip \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục runner
WORKDIR /circleci

# Tải CircleCI Launch Agent
RUN curl -fSL \
  https://circleci-binary-releases.s3.amazonaws.com/circleci-launch-agent/${LAUNCH_AGENT_VERSION}/circleci-launch-agent_linux_amd64 \
  -o /usr/local/bin/circleci-launch-agent \
  && chmod +x /usr/local/bin/circleci-launch-agent

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
