FROM mikewright/docker-dev-base:latest

ENV ERLANG_PACKAGE_VERSION 1:17.3-dfsg-3ubuntu1
ENV ERLANG_VERSION R17B03

RUN apt-get update && \
    apt-get install -y erlang && \
    /cleanup

ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN /update-vim

#RUN (crontab -l 2>/dev/null; echo "*/5 * * * * /path/to/vim-erlang-tags/bin/vim-erlang-tags.erl") | crontab -

