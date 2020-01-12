FROM httpd:alpine

RUN apk add --no-cache openssh supervisor

RUN ssh-keygen -A

COPY supervisor.conf /etc/supervisor.conf

CMD [ "supervisord", "-c", "/etc/supervisor.conf" ] 
