# Fedora Workstation Setup Script
Bash script to set up a fresh install of Fedora Workstation.


# Documentation

Version 5.18

Supported Fedora Workstation Versions: 38

Recommended Free Space: 40 GB

**Please Run Script After Following Instructions Here**

<ins>_**Make sure to enable Third-Party Repositories during initial setup!!!**_</ins>

<ins>_**Make sure to update your system using the system’s software center and reboot before performing any tasks here and running the script. Failing to do so may result in severe breakage!!!**_</ins>

**The Extras folder also contains other tools you may want.**


Please install .rpm files and files using other types of installation formats using files manually (if you have them).

Please add yourself to `vboxusers` using `sudo usermod -aG vboxusers $USER` and then reboot. Only do this if you have VirtualBox installed. As the RPMFusion Free repository includes VirtualBox, the full install option in this script will install VirtualBox, thus, this part of setup will be automated within the script. This command should only be manually used if the user uses the minimal install option and installs VirtualBox manually. 


# Keyboard Shortcuts:

Change “Settings” to “Super+I”

Change “Toggle Fullscreen Mode” to “Super+F11”

Add shortcut to open “gnome-terminal” with “Ctrl+Alt+T”

Add shortcut to open “gnome-system-monitor” with “Super+Backspace”

Refer to image for media controls on desktop keyboards.


# GNOME Extensions:

This is to be done after running the script!!!

Install using Extension Manager. 

- Caffeine – eon (disable Notifications)
- Lock Keys – kazimieras.vaina (set Indicator Style to Show/Hide)
- Rounded Window Corners – yilozt
- Alphabetical App Grid – stuarthayhurst
- Legacy (GTK3) Theme Scheme Auto Switcher – mukul29

Enable (install if not available) using Extension Manager. 
- AppIndicator and KStatusNotifierItem Support – 3v1n0


# Run Script:

Mark the script as executable by changing it in file properties or running `chmod +x /path/to/file`. Then run it in Terminal with `bash /path/to/file`


# Media Shortcuts Image:
![Error](https://github.com/TechnologyMan101/fedora-workstation-setup-script/blob/main/Media%20Shortcuts%20for%20Desktop%20Keyboards.png?raw=true)


# VM Users

Minimal Install is recommended. VM Tools can be found at https://mega.nz/folder/sBwwxBTR#zf6d3UaJYnNGl5tXaN63ag in Extras or at https://github.com/TechnologyMan101/script-extras/releases.


# Other Notes

NVIDIA users must install the proprietary driver separately, as well as switch to the GNOME on X11 session prior to logging in by using the session menu located in the bottom right corner of the screen on the login screen. 
