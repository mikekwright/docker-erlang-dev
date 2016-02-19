FROM ubuntu:vivid

ENV ERLANG_PACKAGE_VERSION 1:17.3-dfsg-3ubuntu1
ENV ERLANG_VERSION R17B03

ADD run-cleanup /run-cleanup

RUN apt-get update && \
    apt-get install -y git vim curl cron && \
    /run-cleanup

RUN apt-get update && \
    apt-get install -y erlang && \
    /run-cleanup

ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN curl http://j.mp/spf13-vim3 -L -o - | sh

RUN mkdir /src
WORKDIR /src

#RUN (crontab -l 2>/dev/null; echo "*/5 * * * * /path/to/vim-erlang-tags/bin/vim-erlang-tags.erl") | crontab -

