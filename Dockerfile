FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    unzip \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Tạo thư mục runner
WORKDIR /circleci

# Tải binary CircleCI runner mới nhất
RUN curl -L https://circleci-binary-releases.s3.amazonaws.com/circleci-runner-release/latest/linux/amd64/circleci-runner \
    -o /usr/local/bin/circleci-runner && \
    chmod +x /usr/local/bin/circleci-runner

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
