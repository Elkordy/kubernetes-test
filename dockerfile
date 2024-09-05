FROM centos:latest

# Maintainer information
LABEL maintainer="muhammadelekrady@gmail.com"

# Update the repository links and install necessary packages
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum -y install java httpd zip unzip wget && \
    yum clean all

# Download and extract the website template
WORKDIR /var/www/html/
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip -q photogenic.zip && \
    cp -rv photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose the default HTTP port 80
EXPOSE 80

# Start Apache HTTP server in the foreground ---
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]