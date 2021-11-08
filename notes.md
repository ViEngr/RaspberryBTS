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
