FROM registry.access.redhat.com/ubi8:latest

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y update
RUN dnf -y install yum-utils
RUN yum-config-manager --enable codeready-builder-for-rhel-8-x86_64-rpms
RUN dnf -y install epel-release glibc-devel.i686 libstdc++.i686
RUN dnf -y groupinstall "Development Tools" "RPM Development Tools"
RUN dnf -y install xcb-util-devel.i686 xcb-util-keysyms-devel.i686 xcb-util-wm-devel.i686 vulkan-loader-devel.i686 spirv-tools-devel.i686 spirv-tools-libs.i686 spirv-headers-devel
RUN dnf -y install check-devel.i686
RUN dnf -y install flac-devel.i686 alsa-lib-devel.i686
RUN dnf -y install cmake SDL2-devel.i686 gstreamer1-devel.i686 gstreamer1-plugins-base-devel.i686
RUN dnf -y install cyrus-sasl-devel.i686 openldap-devel.i686
RUN dnf -y install openal-soft-devel.i686 libva-devel.i686 libattr-devel.i686 gtk3-devel.i686 vulkan-loader-devel.i686 SDL2-devel.i686 mpg123-devel.i686 gstreamer1-plugins-base-devel.i686 gstreamer1-devel.i686 gettext-devel.i686 libtiff-devel.i686 libv4l-devel.i686 gsm-devel.i686 pulseaudio-libs-devel.i686 gnutls-devel.i686 dbus-devel.i686 libXcursor-devel.i686 libXi-devel.i686 libXmu-devel.i686 cups-devel.i686 giflib-devel.i686 fontconfig-devel.i686 libXcomposite-devel.i686 libXinerama-devel.i686 libXext-devel.i686 libXrandr-devel.i686 libXrender-devel.i686 libXxf86dga-devel.i686 libXxf86vm-devel.i686 mesa-libGL-devel.i686 mesa-libGLU-devel.i686 mesa-libOSMesa-devel.i686 libX11-devel.i686 libpcap-devel.i686 libgphoto2-devel.i686 fontforge.i686 freetype-devel.i686 zlib-devel.i686 systemd-devel.i686 sane-backends-devel.i686 unixODBC-devel.i686 openldap-devel.i686 ncurses-devel.i686 libxslt-devel.i686 libxml2-devel.i686 libusb-devel.i686 libstdc++-devel.i686 librsvg2-devel.i686 libpng-devel.i686 libjpeg-turbo-devel.i686 libieee1284-devel.i686 lcms2-devel.i686 freeglut-devel.i686 alsa-lib-devel.i686 chrpath fontpackages-devel icoutils mingw32-gcc mingw64-gcc


COPY build.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/build.sh"]
