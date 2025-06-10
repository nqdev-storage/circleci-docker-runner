FROM ubuntu:20.04

USER root

ENV DEBIAN_FRONTEND=noninteractive

# Cài đặt curl và CA certificates
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Tạo thư mục làm việc cho runner
RUN mkdir -p /runner/data

# Tải CircleCI runner binary
RUN curl -L -o /usr/local/bin/circleci-runner https://circleci-binary-releases.s3.amazonaws.com/circleci-runner/latest/circleci-runner-linux-amd64 && \
    chmod +x /usr/local/bin/circleci-runner

# Copy script khởi động
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
