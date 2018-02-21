#!/bin/bash
 
if [ "$(whoami)" != "root" ]; then
	echo "Sorry, this script must be executed with sudo or as root"
	exit 1
fi

echo 
echo "----------------"
echo "Updating sources"
echo "----------------"
echo
 
echo
echo "-------------------"
echo "Installing the required packages..."
echo "-------------------"
echo
 
apt-get update -y && dist-upgrade -y && rpi-update && sudo apt-get autoremove -y
apt-get install -y apache2 php7.0 sqlite3 php7.0-sqlite php7.0-gd imagemagick libimage-exiftool-perl usbmount screen rsync

echo 
echo "-----------------------"
echo "Installing dependencies"
echo "-----------------------"
echo

apt-get install -y libltdl-dev libusb-dev libexif-dev libpopt-dev libusb-1.0-0-dev
apt-get install -y acl git-core screen rsync exfat-fuse exfat-utils ntfs-3g minidlna hfsutils hfsprogs

echo 
echo "-------------------------"
echo "Creating temporary folder"
echo "-------------------------"
echo

mkdir gphoto2-temp-folder
cd gphoto2-temp-folder

echo 
echo "-------------------------"
echo "Downloading libusb 1.0.11"
echo "-------------------------"
echo

wget http://ftp.de.debian.org/debian/pool/main/libu/libusbx/libusbx_1.0.11.orig.tar.bz2
tar xjvf libusbx_1.0.11.orig.tar.bz2
cd libusbx-1.0.11/

echo 
echo "--------------------------------------"
echo "Compiling and installing libusb 1.0.11"
echo "--------------------------------------"

./configure
make
make install
cd ..

echo 
echo "-------------------------------------------"
echo "Downloading and installing RPi_Cam_Web_Interface"
echo "-------------------------------------------"
echo

raspi-config nonint do_camera 0
git clone https://github.com//silvanmelchior/RPi_Cam_Web_Interface
./RPi_Cam_Web_Interface_Installer.sh

echo 
echo "-----------------"
echo "Linking libraries"
echo "-----------------"  
echo

ldconfig

echo which 
echo "-------------------"
echo "Removing temp files"
echo "-------------------"
echo

cd ..
rm -r gphoto2-temp-folder

cd ~

echo 
echo "--------------------"
echo "All done!"
echo "--------------------"
echo
