# 使用 nginx 官方映像
FROM nginx:alpine

# 安裝 iproute2 取得 ip 命令
RUN apk add --no-cache iproute2 bash

# 建立 entrypoint script 動態生成 index.html
RUN mkdir -p /docker-entrypoint-init.d
RUN echo '#!/bin/bash\n\
ip_addr=$(hostname -i)\n\
echo "<html><body><h1>IP: ${ip_addr}</h1></body></html>" > /usr/share/nginx/html/index.html\n\
exec nginx -g "daemon off;"\n' > /docker-entrypoint-init.d/start.sh && \
    chmod +x /docker-entrypoint-init.d/start.sh

# 以我們自訂 script 啟動
CMD ["/docker-entrypoint-init.d/start.sh"]
