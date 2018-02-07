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
 
apt-get update
apt-get install apache2 php5 sqlite3 php5-sqlite php5-gd imagemagick libimage-exiftool-perl git usbmount screen samba samba-common-bin rsync

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
echo "-------------------------"
echo "Downloading libgphoto2 2.5.16"
echo "-------------------------"
echo

wget http://downloads.sourceforge.net/project/gphoto/libgphoto/2.5.16/libgphoto2-2.5.16.tar.gz
tar xzvf libgphoto2-2.5.16.tar.gz
cd libgphoto2-2.5.16

echo 
echo "-----------------------------------"
echo "Compiling and installing libgphoto2 2.5.16"
echo "-----------------------------------"
echo

./configure
make
make install
cd ..

echo 
echo "-------------------------"
echo "Downloading gphoto2 2.5.15"
echo "-------------------------"
echo

wget http://downloads.sourceforge.net/project/gphoto/gphoto/2.5.15/gphoto2-2.5.15.tar.gz
tar xzvf gphoto2-2.5.15.tar.gz
cd gphoto2-2.5.15

echo 
echo "--------------------------------"
echo "Compiling and installing gphoto2"
echo "--------------------------------" 
echo

./configure
make
make install
cd ..

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
echo "-------------------"
echo "Copying files to the /var/www directory..."
echo "-------------------"
echo
 
cp rpi-photo-web/ /var/www
 
echo
echo "-------------------"
echo "Configuring Samba..."
echo "-------------------"
echo
 
smbpasswd -a pi
/etc/init.d/samba restart
 
echo
echo "-------------------"
echo "Samba has been configured."
echo "Open the /etc/samba/smb.conf file and edit the path parameter in the [Photos] section."
echo "Restart Samba using the sudo /etc/init.d/samba restart command."
echo "-------------------"
echo

read -p "Press [Enter] to continue..."
 
echo
echo "-------------------"
echo "All done! Press [Enter] to reboot the system. Connect to the Raspberry Pi Ad-Hoc network."
echo "-------------------"
echo

read -p
 
echo 
echo "--------------------"
echo "All done!"
echo "--------------------"
echo
