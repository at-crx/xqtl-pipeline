FROM gaow/base-notebook
LABEL MAINTAINER Hao Sun
ENV PATH=/opt/R-4.2.0:$PATH
RUN apt-get update && \
apt-get install -y --no-install-recommends \
git-all \
libboost-all-dev \
libgsl-dev && \
apt-get upgrade -y --no-install-recommends \
gfortran \
libreadline6-dev \
libx11-dev \
libxt-dev \
libpng-dev \
libjpeg-dev \
libcairo2-dev \
xvfb \
libbz2-dev \
libzstd-dev \
liblzma-dev \
libcurl4-openssl-dev \
texinfo \
texlive \
texlive-fonts-extra \
screen \
libpcre2-dev
RUN cd /opt && \
wget https://cran.r-project.org/src/base/R-4/R-4.2.0.tar.gz && \
tar zxvf R-4.2.0.tar.gz && \
cd R-4.2.0 && \
./configure --enable-R-shlib && \
make && make install
RUN R --slave -e 'install.packages("BiocManager")'
RUN R --slave -e 'BiocManager::install("psichomics")'
CMD exec /bin/bash "$@"
