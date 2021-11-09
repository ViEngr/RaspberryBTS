To monitor usage:
github: https://github.com/novaspirit/rpi_conky

conky settings: http://conky.sourceforge.net/config_settings.html 

---install conky,

$ sudo apt-get install conky -y

now lets download the conky configuration file

$ wget -O /home/pi/.conkyrc https://raw.githubusercontent.com/novaspirit/rpi_conky/master/rpi3_conkyrc

to autostart conky on boot we will need to create 2 files, 
1 will be a shell script to delay the boot process of conky. 
2 will be the conky desktop files to allow lxdesktop to start the shell script

to create the shell script

sudo nano /usr/bin/conky.sh

paste this into the conky.sh file

#!/bin/sh
(sleep 4s && conky) &
exit 0

now lets create the conky.desktop file for the autostart process

sudo nano /etc/xdg/autostart/conky.desktop

and paste this into the file

[Desktop Entry]
Name=conky
Type=Application
Exec=sh /usr/bin/conky.sh
Terminal=false
Comment=system monitoring tool.
Categories=Utility;

the last thing to do is to reboot to make sure everything is working!


-----------------
intsll telnet:rs apt-get install telnet
check noise on the channel picked: mbts noise

Patch yatebts configure error:
# Dry-run first to make sure there are no issues
[yatebts-tarball]$ patch --dry-run -p1 -i yatebts-5.0.0-gcc6.patch
checking file mbts/GPRS/MSInfo.cpp                                      
checking file mbts/SGSNGGSN/Sgsn.cpp                                    
Hunk #2 succeeded at 253 (offset 1 line).                               

# No issues, so actually apply the patch
[yatebts-tarball]$ patch -p1 -i yatebts-5.0.0-gcc6.patch

# Proceed with normal build steps


Try to add php5(did not worked), worked php5.6

sudo echo "deb http://mirrordirector.raspbian.org/raspbian/ jessie main contrib non-free rpi" >> /etc/apt/sources.list
sudo apt-get update
sudo update-alternatives --set php /usr/bin/php5
 this did not worked, maybe together with the next...

--------------------

#!/bin/bash

# credits: http://stackoverflow.com/questions/31280912/how-to-install-php-5-6-on-raspbian-wheezy

### VARIABLES ###

# type here the specific php 5.x version you want to install
PHP_VERSION="5.6.20"

### SCRIPT ###

# check if script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "Sorry, you have to be root."
    echo "Try again using sudo"
    exit 1
else
    echo "Running as root..."
fi

# getting real number of cores
# CORES=$(cat /proc/cpuinfo | grep Hardware | wc -l)

# Check PHP version before start
# latest version in repo should be 5.4, which is no longer supported.
echo "Currently installed PHP version is..."
php -v

# working in temporary dir
mkdir -p /tmp/php_install
cd /tmp/php_install

# Get the PHP source
# You can find the latest version number on the PHP download page: http://php.net/downloads.php
# Change `nl1` to your nearest mirror. Find the mirror list here: http://php.net/mirrors.php.
wget http://nl1.php.net/distributions/php-$PHP_VERSION.tar.bz2

# Unpack
tar -xvjf php-$PHP_VERSION.tar.bz2

cd php-$PHP_VERSION

apt-get update
apt-get install libxml2-dev
./configure

# getting cpu architecture
RPI_HW=$(cat /proc/cpuinfo | grep Hardware | awk '{print $3}' | head -1)

if [ "$RPI_HW" = "BCM2709" ]; then
    # if on RPi 2 or RPi 3 use 4 cores.
    make -j4
else
    # if on RPi 1 or unrecognized cpu (future Pis?) use 1 core
    make
fi

make install

# Check PHP version
echo "now printing the newly installed PHP version..."
php -v

-------------

Fix missing libusb 
find /  -name  libusb-1.0-0*
apt list --installed libusb*
