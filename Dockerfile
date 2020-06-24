# FROM ivanpondal/alpine-latex:1.1.0
# shameless copied stuff from https://github.com/dc-uba/docker-alpine-texlive

FROM alpine

# RUN mkdir /tmp/install-tl-unx

#WORKDIR /tmp/install-tl-unx

#COPY texlive.profile .

#ENV PATH="/usr/local/texlive/2018/bin/x86_64-linuxmusl:${PATH}"

# Install TeX Live 2018 with some basic collections http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
#RUN apk update && \
#    # need this as busybox wget is not sufficient\
#    apk --no-cache add perl wget xz tar && \
#	wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
#	# got this from https://www.tug.org/texlive/acquire-netinstall.html \
#	tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
#	./install-tl --profile=texlive.profile && \
#	#tlmgr install collection-latex collection-latexextra collection-langspanish && \
#	apk del perl wget xz tar && \
#	cd && \
#	rm -rf /tmp/install-tl-unx



## Install additional packages
#RUN apk --no-cache add perl wget && \
#	#tlmgr install bytefield algorithms algorithm2e ec fontawesome && \
#	apk del perl wget && \
#	mkdir /workdir

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linuxmusl:${PATH}"

WORKDIR /workdir

VOLUME ["/workdir"]

## end of tex

RUN apk update &&\
    apk add texlive-xetex texmf-dist-latexextra

# from https://github.com/cybercode/alpine-ruby/blob/master/Dockerfile
# guess ist is to install native extensions

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
      && apk update \
      && apk add --update-cache postgresql-client nodejs \
        libffi-dev readline sqlite build-base postgresql-dev \
        libc-dev linux-headers libxml2-dev libxslt-dev readline-dev gcc libc-dev \
      && rm -rf /var/cache/apk/*

RUN apk update && apk upgrade && apk --update add \
    ruby ruby ruby-dev ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler  \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc\

# from https://hub.docker.com/r/ciandt/docker-alpine-pandoc/dockerfile^\
# install pandoc
RUN \
    apk add ca-certificates wget \
    && wget -O /tmp/pandoc.tar.gz https://github.com/jgm/pandoc/releases/download/2.5/pandoc-2.5-linux.tar.gz \
    && tar xvzf /tmp/pandoc.tar.gz --strip-components 1 -C /usr/local/ \
    && ln /usr/local/bin/pandoc /usr/local/bin/pandoc_2.5 \
    && update-ca-certificates \
    && apk del wget ca-certificates\
    && rm /tmp/pandoc.tar.gz

# don't know exactly where i found this - got it by try/error
RUN  apk update && apk fetch openjdk11-jre && apk add openjdk11 fontconfig

# from https://github.com/miy4/docker-plantuml/blob/master/Dockerfile

ENV PLANTUML_VERSION 1.2019.13
ENV LANG en_US.UTF-8
RUN apk add --no-cache graphviz ttf-droid ttf-droid-nonlatin curl \
    && mkdir /app \
    && curl -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download -o /app/plantuml.jar \
    && apk del curl


RUN  apk update && apk add graphviz  && rm -rf /var/lib/apt/lists/*

RUN gem install --no-document wortsammler

ENTRYPOINT ["wortsammler"]

CMD [ "-h" ]




