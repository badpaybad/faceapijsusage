#FROM nginx:latest
FROM ubuntu:20.04
#FROM docker.angie.software/angie:1.2.0-ubuntu
#FROM docker.angie.software/angie:1.2.0-alpine

RUN apt-get update -y && apt-get install -y apt-transport-https lsb-release \
               ca-certificates curl gnupg2 nano

RUN  curl -o /etc/apt/trusted.gpg.d/angie-signing.gpg \
            https://angie.software/keys/angie-signing.gpg
RUN echo "deb https://download.angie.software/angie/ubuntu/ `lsb_release -cs` main" \
       | tee /etc/apt/sources.list.d/angie.list > /dev/null

RUN apt-get update && apt-get install -y angie


COPY ./angie.nginx.conf /etc/angie/conf.d/default.conf

# RUN echo "server {" >> /etc/nginx/conf.d/default.conf
# RUN echo "  listen 80;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "  server_name _;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "  location / {" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "      root /usr/share/nginx/html;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "      try_files \$uri /index.html;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "      index  index.html index.htm;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "  }" >> "/etc/nginx/conf.d/default.conf"

# RUN echo "  error_page   500 502 503 504 404  /50x.html;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "  location = /50x.html {" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "      root   /usr/share/nginx/html;" >> "/etc/nginx/conf.d/default.conf"
# RUN echo "  }" >> "/etc/nginx/conf.d/default.conf"

# RUN echo "}" >> "/etc/nginx/conf.d/default.conf"

#COPY  / /usr/share/nginx/html
COPY  / /usr/share/angie/html
RUN  ln -sf /dev/stdout /var/log/angie/access.log \
        && ln -sf /dev/stderr /var/log/angie/error.log

RUN apt-get -y clean && apt-get remove --auto-remove --purge -y lsb-release
 
EXPOSE 80

CMD ["angie", "-g", "daemon off;"]


#docker build --no-cache -f "Dockerfile" -t "facejsusage"  .
#docker build -f "Dockerfile" -t "facejsusage"  .
#docker run -it --rm -p 9113:80 --name facejsusage_9113 facejsusage


# rename so thu tu tang dan
# ls -v | cat -n | while read n f; do mv -n "$f" "$n.jpg"; done
