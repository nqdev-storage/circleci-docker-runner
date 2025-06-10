FROM circleci/runner:f2489d2-dev

# Sao chép vào thư mục không bị giới hạn
COPY entrypoint.sh /tmp/entrypoint.sh

# Đặt quyền thực thi (vì trong /tmp bạn có quyền)
RUN chmod +x /tmp/entrypoint.sh

# Dùng entrypoint từ /tmp
ENTRYPOINT ["/tmp/entrypoint.sh"]
