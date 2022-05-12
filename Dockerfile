FROM registry.access.redhat.com/ubi8:latest

# setup repos
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y update
RUN dnf -y install yum-utils
RUN yum-config-manager --enable codeready-builder-for-rhel-8-x86_64-rpms

#Copy / install wine i686 rpms
COPY ./RPMS/i686/*rpm /tmp/
COPY ./RPMS/noarch/*rpm /tmp/
RUN dnf -y install /tmp/*.rpm
RUN rm -fr /tmp/*.rpm

# install X and some utils
RUN dnf -y install xorg-x11-server-Xvfb tigervnc-server-minimal procps-ng net-tools lsof

# clean up
RUN dnf -y clean all
RUN rm -fr /var/cache/dnf
RUN rm -fr /tmp/RPMS

# add unprivelaged user
RUN	groupadd -g 1000 user
RUN	useradd -ms /bin/bash -u 1000 -g 1000 user

# copy winetricks, entry point and windows exe
COPY winetricks /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
COPY server.exe /usr/local/bin/

# copy geco and mono so we don't have to do it later
RUN mkdir -p /home/user/.cache/wine/
COPY wine-gecko-2.47.2-x86_64.msi /home/user/.cache/wine/
COPY wine-gecko-2.47.2-x86.msi /home/user/.cache/wine/
COPY wine-mono-5.1.1-x86.msi /home/user/.cache/wine/

# set home permissions
RUN chown -R 1000.1000 /home/user

# vars and user
ARG DISPLAY
ENV DISPLAY=:0.0
USER 1000

# entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
