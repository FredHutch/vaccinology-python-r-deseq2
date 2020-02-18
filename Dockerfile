################################################################################
### Build Docker image for using DESeq2 and Python3

FROM ubuntu:bionic-20191202

# need to download this https://www.bioconductor.org/packages/release/bioc/src/contrib/DESeq2_1.26.0.tar.gz
# FROM quay.io/biocontainers/bioconductor-deseq2:1.26.0--r36he1b5a44_0 -- this is essentially broken for building off of


RUN ["useradd", "appuser", "-s", "/bin/bash", "-m", "-g", "users", "-G", "users"]

### package install

RUN ["apt-get", "update"]
RUN ["apt-get", "-q", "-y", "install", "wget", "build-essential", "gfortran", "libreadline-dev", "zlib1g-dev", "libbz2-dev", "liblzma-dev", "libpcre16-3", "libpcre3-dev", "libpcre32-3", "libpcrecpp0v5", "libcurl4-openssl-dev", "libxml2-dev", "libpng-dev", "libjpeg-dev", "python3", "python3-pip"]


ENV HOME /home/appuser
RUN ["mkdir", "/home/appuser", "-p"]

################################################################################
### Python modules install

USER root:root
WORKDIR /home/appuser/
RUN ["pip3", "install", "pandas", "numpy", "scipy"]

# --chown:appuser:users had error
COPY quickr/ /home/appuser/quickr/  
USER root:root
RUN ["chown", "-R", "appuser:users", "/home/appuser/quickr"]
WORKDIR /home/appuser/quickr/
RUN ["python3", "setup.py", "install"]


################################################################################
### R and DESeq2 install

#USER appuser:users
USER root:root
WORKDIR /home/appuser/

RUN /bin/bash -c 'wget https://cran.r-project.org/src/base/R-3/R-3.6.1.tar.gz;  \
tar zxvf R-3.6.1.tar.gz; \
cd /home/appuser/R-3.6.1; \
./configure --with-x=no && make && make install && rm -rf /home/appuser/R-3.6.1'




WORKDIR /home/appuser
#RUN ["rm", "-rf", "/home/appuser/R-3.6.1"]
RUN ["chown", "-R", "appuser:users", "/home/appuser"]



USER appuser:users
COPY install.r /home/appuser
COPY rprofile.txt /home/appuser/.Rprofile

RUN ["mkdir", "/home/appuser/R/x86_64-pc-linux-gnu-library", "-p"]
USER root:root
RUN ["R", "CMD", "BATCH", "install.r", "install.Rout"]


################################################################################


#COPY profile.txt /home/appuser/.bashrc
COPY [ "scrape_software_versions.py", "/home/appuser/"]

USER root:root
RUN ["chown", "-R", "appuser:users", "/home/appuser/.bashrc", "/home/appuser/scrape_software_versions.py"]


USER appuser:users


