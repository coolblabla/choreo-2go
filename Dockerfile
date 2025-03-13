FROM node:latest

WORKDIR /home/choreouser

EXPOSE 3000

COPY files/* /home/choreouser/

RUN apt-get update &&\
    apt install --only-upgrade linux-libc-dev &&\
    apt-get install -y iproute2 vim netcat-openbsd gettext-base &&\
    addgroup --gid 10008 choreo &&\
    # 移除 --no-create-home，让系统创建家目录
    adduser --disabled-password --uid 10008 --ingroup choreo choreouser &&\
    # 确保工作目录权限正确
    chown -R choreouser:choreo /home/choreouser &&\
    chmod -R 755 /home/choreouser &&\
    usermod -aG sudo choreouser &&\
    chmod +x index.js swith web server &&\
    npm install
# 使用shell形式的CMD直接执行envsubst命令和启动node
CMD if [ -f "config.template.json" ]; then envsubst < config.template.json > config.json; fi && node index.js

USER 10008
