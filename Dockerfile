FROM mikewright/docker-dev-base:ubuntu

MAINTAINER Mike Wright <mkwright@gmail.com>

# Install dependencies
RUN apt-get update && \
    apt-get install -y autoconf libncurses-dev build-essential && \
    apt-get install -y libssl-dev && \
    apt-get install -y libwxgtk2.8-dev libgl1-mesa-dev libglu1-mesa-dev libpng3 && \
    apt-get install -y default-jdk && \
    apt-get install -y g++ && \
    /cleanup

#RUN apk add --update autoconf ncurses-libs g++ make openssl-dev && \
#    apk add openssl-dev && \
#    apk add wxgtk2.8-dev libpng-dev mesa-dev && \
#    apk add openjdk8 && \
#    /cleanup

# Install Erlang/OTP
ENV ERLANG_VERSION OTP-18.2.3
ENV ERL_TOP /erlang
ENV PATH $ERL_TOP/bin:$PATH
RUN git clone https://github.com/erlang/otp.git /erlang && \
    cd /erlang && git checkout tags/$ERLANG_VERSION -b $ERLANG_VERSION && cd / && \
    cd /erlang && ./otp_build autoconf && ./configure && make && make install && cd / 

# Install Rebar
ENV REBAR_VERSION 2.6.1
RUN git clone https://github.com/rebar/rebar.git /rebar-src && \
    cd /rebar-src && git checkout tags/$REBAR_VERSION -b $REBAR_VERSION && cd / && \
    cd /rebar-src && ./bootstrap && cd / && \
    mv /rebar-src/rebar /bin/rebar && \
    rm -rf /rebar-src

# Install vim plugins for erlang 
ADD vimrc.bundles.local /root/.vimrc.bundles.local
RUN /update-vim

#RUN (crontab -l 2>/dev/null; echo "*/5 * * * * /path/to/vim-erlang-tags/bin/vim-erlang-tags.erl") | crontab -

