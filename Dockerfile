FROM korjavin/korjavin-base

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cron supervisor

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libdatetime-format-sqlite-perl libdbd-sqlite3-perl libdbix-class-schema-loader-perl git

RUN mkdir -p /var/www && cd /var/www && git clone https://github.com/korjavin/mojo.git && cd mojo && git checkout tags/sip_cloud && mkdir web_shop

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 9090

VOLUME ["/var/www/mojo/web_shop/"]
VOLUME ["/etc/cron.d/"]

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
