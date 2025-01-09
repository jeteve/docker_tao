# This old TAO+ACE can be build on an antique distrib.
ARG BUILD_IMAGE="setmeplease"
ARG RUNTIME_IMAGE=$BUILD_IMAGE

FROM $BUILD_IMAGE AS builder

ARG LEGACY=0
ARG TAO_VERSION

# See https://www.stephenrlang.com/2017/03/setting-up-the-old-releases-repo-for-ubuntu/
RUN if [ $LEGACY -eq 1 ]; then sed -i 's/archive\./old-releases\./' /etc/apt/*.list ; fi

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update -q
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y nano


# ACE + TAO
RUN wget --no-check-certificate http://download.dre.vanderbilt.edu/previous_versions/ACE+TAO-$TAO_VERSION.tar.gz
RUN tar -xvf ACE+TAO-$TAO_VERSION.tar.gz -C /opt
ENV ACE_ROOT /opt/ACE_wrappers
ENV TAO_ROOT $ACE_ROOT/TAO
ENV PATH $PATH:$ACE_ROOT/bin
# there is a bug in Docker so we cannot use (https://github.com/dotcloud/docker/issues/2637)
#ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$ACE_ROOT/lib
# instead
ENV LD_LIBRARY_PATH $ACE_ROOT/lib

ADD config.h /opt/ACE_wrappers/ace/config.h
ADD platform_macros.GNU /opt/ACE_wrappers/include/makeinclude/platform_macros.GNU

ENV INSTALL_PREFIX=/usr/local/tao/

# build ACE first
RUN cd $ACE_ROOT/ace;make -j 8
#build gperf
RUN cd $ACE_ROOT/apps/gperf/src;make -j 4
RUN cd $TAO_ROOT;make -j 4
RUN cd $ACE_ROOT;make install
RUN cd $TAO_ROOT;make install

# See https://www.dre.vanderbilt.edu/~schmidt/DOC_ROOT/ACE/ACE-INSTALL.html

FROM $RUNTIME_IMAGE
ARG TAO_PREFIX=/usr/local/tao/
COPY --from=builder $TAO_PREFIX /usr/local
ENV LD_LIBRARY_PATH /usr/local/lib

