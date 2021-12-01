FROM dinotools/dionaea:latest

COPY config/dionaea.cfg /opt/dionaea/etc/dionaea/dionaea.cfg
COPY config/ihandlers /opt/dionaea/etc/dionaea/ihandlers-enabled/
COPY config/services /opt/dionaea/etc/dionaea/services-enabled/

CMD /opt/dionaea/bin/dionaea -l info -L '*' -c /opt/dionaea/etc/dionaea/dionaea.cfg
