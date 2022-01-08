defaults write com.apple.dock autohide-delay -float 0; killall Dock
Restore the default behavior using: defaults delete com.apple.dock autohide-delay; killall Dock

To add at App to Startup :
sudo nano /etc/xdg/autostart/display.desktop

then add here:

[Desktop Entry]
Name=YateBTS
Exec=yate

Ctrl O ---- "O" from Orange to save
Enter
Ctrl X

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

mkdir -p /tmp/php_install
cd /tmp/php_install

wget https://www.php.net/distributions/php-5.6.40.tar.bz2
tar -xvjf php-$PHP_VERSION.tar.bz2

cd php-5.6.40

apt-get update
apt-get install libxml2-dev
./configure
make -j4
make install

echo "now printing the newly installed PHP version..."
php -v

-------------

Fix missing libusb 
find /  -name  libusb-1.0-0*
apt list --installed libusb*


The standard Ubuntu directory structure mostly follows the Filesystem Hierarchy Standard, which can be referred to for more detailed information.

Here, only the most important directories in the system will be presented.

/bin is a place for most commonly used terminal commands, like ls, mount, rm, etc.

/boot contains files needed to start up the system, including the Linux kernel, a RAM disk image and bootloader configuration files.

/dev contains all device files, which are not regular files but instead refer to various hardware devices on the system, including hard drives.

/etc contains system-global configuration files, which affect the system's behavior for all users.

/home home sweet home, this is the place for users' home directories.

/lib contains very important dynamic libraries and kernel modules

/media is intended as a mount point for external devices, such as hard drives or removable media (floppies, CDs, DVDs).

/mnt is also a place for mount points, but dedicated specifically to "temporarily mounted" devices, such as network filesystems.

/opt can be used to store additional software for your system, which is not handled by the package manager.

/proc is a virtual filesystem that provides a mechanism for kernel to send information to processes.

/root is the superuser's home directory, not in /home/ to allow for booting the system even if /home/ is not available.

/run is a tmpfs (temporary file system) available early in the boot process where ephemeral run-time data is stored. Files under this directory are removed or truncated at the beginning of the boot process.
(It deprecates various legacy locations such as /var/run, /var/lock, /lib/init/rw in otherwise non-ephemeral directory trees as well as /dev/.* and /dev/shm  which are not device files.)

/sbin contains important administrative commands that should generally only be employed by the superuser.

/srv can contain data directories of services such as HTTP (/srv/www/) or FTP.

/sys is a virtual filesystem that can be accessed to set or obtain information about the kernel's view of the system.

/tmp is a place for temporary files used by applications.

/usr contains the majority of user utilities and applications, and partly replicates the root directory structure, containing for instance, among others, /usr/bin/ and /usr/lib.

/var is dedicated to variable data, such as logs, databases, websites, and temporary spool (e-mail etc.) files that persist from one boot to the next. A notable directory it contains is /var/log where system log files are kept.

