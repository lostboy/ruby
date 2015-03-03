FROM cloudgear/build-deps:14.04

# Use a version available on the Brightbox repo (https://www.brightbox.com/docs/ruby/ubuntu/)
# ENV RUBY_VERSION 2.0
# ENV REALLY_GEM_UPDATE_SYSTEM 1

RUN apt-get update -q && \
    apt-get install ruby2.0 && \

    rm /usr/bin/ruby /usr/bin/gem /usr/bin/irb /usr/bin/rdoc /usr/bin/erb && \
    ln -s /usr/bin/ruby2.0 /usr/bin/ruby && \
    ln -s /usr/bin/gem2.0 /usr/bin/gem && \
    ln -s /usr/bin/irb2.0 /usr/bin/irb && \
    ln -s /usr/bin/rdoc2.0 /usr/bin/rdoc && \
    ln -s /usr/bin/erb2.0 /usr/bin/erb && \
    
    echo 'gem: --no-document' > /etc/gemrc && \

    gem update --system && \
    gem pristine --all && \

    gem install bundler

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C3173AA6 && \
#    echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox-ruby-ng-trusty.list && \
#    apt-get update -q && apt-get install -yq --no-install-recommends \
#        ruby$RUBY_VERSION \
#        ruby$RUBY_VERSION-dev \
#        ruby-switch && \

#    # set default ruby with ruby-switch
#    ruby-switch --set ruby$RUBY_VERSION && \

    # clean up
RUN rm -rf /var/lib/apt/lists/* && \
    truncate -s 0 /var/log/*log && \

    # Setup Rubygems

CMD ["/usr/bin/ruby"]