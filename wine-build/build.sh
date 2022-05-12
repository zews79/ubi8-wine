#!/bin/bash

cd ~

rpmdev-setuptree
cd ~/rpmbuild/SRPMS

dnf -y download --source wine vkd3d nss-mdns audiofile FAudio

rpmbuild --rebuild --target i686 vkd3d-*.src.rpm

rpmbuild --rebuild --target i686 nss-mdns-*.src.rpm

rpmbuild --rebuild --target i686 audiofile-*.src.rpm

rpmbuild --rebuild --target i686 FAudio-*.src.rpm

rpm2cpio wine-*.src.rpm | cpio -D ../SOURCES/ -idm
mv ../SOURCES/wine.spec ../SPECS/wine.spec
cd ../SPECS

cat >> wine32.patch << EOF
--- a/wine.spec
+++ b/wine.spec
@@ -201,13 +201,13 @@
 
 # x86-32 parts
 %ifarch %{ix86} x86_64
-%if 0%{?fedora} || 0%{?rhel} <= 6
+%if 0%{?fedora} || 0%{?rhel} <= 8
 Requires:       wine-core(x86-32) = %{version}-%{release}
 Requires:       wine-cms(x86-32) = %{version}-%{release}
 Requires:       wine-ldap(x86-32) = %{version}-%{release}
 Requires:       wine-twain(x86-32) = %{version}-%{release}
 Requires:       wine-pulseaudio(x86-32) = %{version}-%{release}
-%if 0%{?fedora} >= 10 || 0%{?rhel} == 6
+%if 0%{?fedora} >= 10 || 0%{?rhel} >= 6
 Requires:       wine-openal(x86-32) = %{version}-%{release}
 %endif
 %if 0%{?fedora}
@@ -748,6 +748,7 @@
  --x-includes=%{_includedir} --x-libraries=%{_libdir} \\
  --without-hal --with-dbus \\
  --with-x \\
+ --without-opencl \\
 %ifarch %{arm}
  --with-float-abi=hard \\
 %endif
@@ -1979,7 +1980,7 @@
 %{_libdir}/wine/winehid.%{winesys}
 %{_libdir}/wine/winejoystick.drv.so
 %{_libdir}/wine/winemapi.%{winedll}
-%{_libdir}/wine/wineusb.sys.so
+#%{_libdir}/wine/wineusb.sys.so
 %{_libdir}/wine/winevulkan.dll.so
 %{_libdir}/wine/winex11.drv.so
 %{_libdir}/wine/wing32.%{winedll}
EOF

patch -Np1 -i wine32.patch

rpmbuild -bs wine.spec
cd ../SRPMS/

rm -f ../RPMS/i686/*debug* ../RPMS/i686/libvkd3d-utils*

dnf -y install ../RPMS/i686/libvkd3d-*.el8.i686.rpm ../RPMS/i686/*FAudio-*.el8.i686.rpm ../RPMS/i686/audiofile-*.el8.i686.rpm

rpmbuild --rebuild --target i686 wine-*.el8.src.rpm

# ver=6.0.2-1

# dnf -y install wine.x86_64 ../RPMS/i686/wine-${ver}.el8.i686.rpm ../RPMS/i686/wine-core-${ver}.el8.i686.rpm ../RPMS/i686/wine-ldap-${ver}.el8.i686.rpm ../RPMS/i686/wine-cms-${ver}.el8.i686.rpm ../RPMS/i686/wine-twain-${ver}.el8.i686.rpm ../RPMS/i686/wine-pulseaudio-${ver}.el8.i686.rpm ../RPMS/i686/wine-alsa-${ver}.el8.i686.rpm ../RPMS/i686/wine-openal-${ver}.el8.i686.rpm ../RPMS/i686/nss-mdns-*.el8.i686.rpm


