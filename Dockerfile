FROM busybox:musl
RUN adduser -S nop-guide
USER nop-guide
RUN mkdir /home/nop-guide/nop-guide
WORKDIR /home/nop-guide/nop-guide
COPY --chown=nop-guide:root dist .
COPY httpd.conf .
CMD busybox httpd -f -p 3000 -u nop-guide
