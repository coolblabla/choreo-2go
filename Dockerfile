FROM node:latest

WORKDIR /home/choreouser

EXPOSE 3000

COPY files/* /home/choreouser/

RUN apt-get update &&\
    apt install --only-upgrade linux-libc-dev &&\
    apt-get install -y iproute2 vim netcat-openbsd gettext-base &&\
    addgroup --gid 10008 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10008 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x index.js swith web server &&\
    mkdir -p /tmp/config &&\
    chown -R choreouser:choreo /tmp/config &&\
    npm install

# 使用/tmp目录进行配置文件处理
CMD if [ -f "config.template.json" ]; then envsubst < config.template.json > /tmp/config/config.json && cp /tmp/config/config.json .; fi && node index.js

USER 10008
