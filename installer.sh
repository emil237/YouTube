#!/bin/bash
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL YouTube
# ###########################################
#
# Command: wget https://raw.githubusercontent.com/emil237/YouTube/main/installer.sh -qO - | /bin/sh
#
# ###########################################

###########################################
# Configure where we can find things here #
MY_URL="https://raw.githubusercontent.com/emil237/YouTube/main"
TMPDIR='/tmp'
PLUGINDIR='/usr/lib/enigma2/python/Plugins/Extensions'
MYTARPY2="youtube-py2.tar.gz"
MYTARPY3="youtube-py3.tar.gz"
#######################
# Remove Old Version #
rm -rf $PLUGINDIR/YouTube
rm -rf $TMPDIR/*youtube*
sleep 3;
#########################
if [ -f /etc/opkg/opkg.conf ]; then
    STATUS='/var/lib/opkg/status'
    OSTYPE='Opensource'
    OPKG='opkg update'
    OPKGINSTAL='opkg install'
elif [ -f /etc/apt/apt.conf ]; then
    STATUS='/var/lib/dpkg/status'
    OSTYPE='DreamOS'
    OPKG='apt-get update'
    OPKGINSTAL='apt-get install'
fi
sleep 2;
#########################
install() {
    if grep -qs "Package: $1" $STATUS; then
        echo
    else
        $OPKG >/dev/null 2>&1
        echo "   >>>>   Need to install $1   <<<<"
        echo
        if [ $OSTYPE = "Opensource" ]; then
            $OPKGINSTAL "$1"
            sleep 1
        elif [ $OSTYPE = "DreamOS" ]; then
            $OPKGINSTAL "$1" -y
            sleep 1
        fi
    fi
}

#########################
if [ -f /usr/bin/python3 ] ; then
    echo ":You have Python3 image ..."
    sleep 1
    Packagegettext=gettext
    Packagescodecs=python3-codecs
    Packagecore=python3-core
    Packagejson=python3-json
    Packagenetclient=python3-netclient
    Packagepyopenssl=python3-pyopenssl
    Packagetwistedweb=python3-twisted-web
else
    echo ":You have Python2 image ..."
    sleep 1
    Packagegettext=gettext
    Packagescodecs=python-codecs
    Packagecore=python-core
    Packagejson=python-json
    Packagenetclient=python-netclient
    Packagepyopenssl=python-pyopenssl
    Packagetwistedweb=python-twisted-web
fi

# check depends packges if installed
install $Packagegettext
install $Packagescodecs
install $Packagecore
install $Packagejson
install $Packagenetclient
install $Packagepyopenssl
install $Packagetwistedweb

#########################
# Remove old version
if [ $OSTYPE = "Opensource" ]; then
    opkg remove enigma2-plugin-extensions-youtube
else
    apt remove enigma2-plugin-extensions-youtube -y
fi
#########################
clear
sleep 2;
cd $TMPDIR
set -e
echo "Downloading And Insallling YouTube plugin Please Wait ......"
echo
if python --version 2>&1 | grep -q '^Python 3\.'; then
  wget "$MY_URL/$MYTARPY3"
tar -xzf $MYTARPY3  -C /
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
sleep 1;
cd
rm -f /tmp/$MYTARPY3
echo "OK"
	else 
echo "   Install Plugin please wait "
   wget "$MY_URL/$MYTARPY2"
tar -xzf $MYTARPY2  -C /
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
sleep 1;
cd
rm -f /tmp/$MYTARPY2
echo "OK"
	fi
set +e
cd ..
#########################
#########################

sleep 1
echo "#########################################################"
echo "#           YouTube INSTALLED SUCCESSFULLY              #"
sleep 2;
echo "#########################################################"
echo ""
echo ""
echo ""
echo "   UPLOADED BY  >>>>   EMIL_NABIL "   
sleep 4;
echo ""
echo ""
echo ""
echo ""
echo "#           your Device will RESTART Now                #"
sleep 4;
echo "#########################################################"

if [ $OSTYPE = "Opensource" ]; then
    killall -9 enigma2
else
    systemctl restart enigma2
fi

exit 0





