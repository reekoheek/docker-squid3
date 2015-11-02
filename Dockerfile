FROM debian

ENV APT_PROXY http://192.168.1.10:3128

RUN \
  echo "\n\
  Acquire::HTTP::Proxy \"$APT_PROXY\";\n\
  Acquire::HTTPS::Proxy \"$APT_PROXY\";\n\
" > /etc/apt/apt.conf.d/01proxy && \
 echo " \n\
deb http://kambing.ui.ac.id/debian/ jessie main\n\
deb http://kambing.ui.ac.id/debian/ jessie-updates main\n\
deb http://kambing.ui.ac.id/debian-security/ jessie/updates main\n\
" > /etc/apt/sources.list && \
 apt-get -o Acquire::Check-Valid-Until=false update -y
#  apt-get update -y

RUN apt-get install squid3 -y

COPY squid.conf /tmp/squid.conf
COPY entrypoint.sh /entrypoint.sh

# RUN apt-get install vim net-tools -y

ENTRYPOINT ["/entrypoint.sh"]
CMD ["squid3", "-f", "/etc/squid3/squid.conf", "-NYCd", "1"]